import 'package:dio/dio.dart';

abstract class ApiServiceProtocol {
  Future<T> fetchResponse<T>({
    String endpoint, 
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  });
}

class ApiService implements ApiServiceProtocol {
  final String? apiKey;
  final dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  ApiService({required this.apiKey});

  @override
  Future<T> fetchResponse<T>({
    String endpoint = 'top-headlines',
    required Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  }) async {

    if (apiKey == null) {
      throw ApiException(
        userMessage: 'Permission denied. Try again later.', 
        debugMessage: 'Unauthorized: missing API Key',
        statusCode: 401
      );
    }

    properties?['apiKey'] = apiKey;

    try {
      final response = await dio.get(
        endpoint,
        queryParameters: properties
      );

      return fromJson(response.data);
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        switch (dioError.response!.statusCode) {
          case 404:
            throw ApiException(
              userMessage: "Sorry, we couldn't locate that resource.",
              debugMessage: 'Entity not found',
              statusCode: 404
            );
          case 500:
            throw ApiException(
              userMessage: "Oops! We're having a little trouble right now. Please try again in a moment.", 
              debugMessage: 'Internal server error',
              statusCode: 500
            );
          default:
            throw ApiException(
              userMessage: 'An unexpected error occured. Please try again later.',
              debugMessage: 'Unknown error: ${dioError.response!.statusCode}',
              statusCode: dioError.response!.statusCode
            );
        }
      } else {
        throw ApiException(
          userMessage: 'Unable to connect. Please check your internet connection and try again.', 
          debugMessage: 'Connection error: ${dioError.message}; No status code found.'
        );
      }
    } catch (error) {
      throw ApiException(
        userMessage: "An unexpected error occured. Please try again later.",
        debugMessage: 'Unknown error: ${error.toString()}; No status code found.'
      );
    }
  }
}

class ApiException implements Exception {
  final String userMessage;
  final String debugMessage;
  final int? statusCode;

  ApiException({required this.userMessage, required this.debugMessage, this.statusCode});

  @override
  String toString() => 'ApiExpection(statusCode: $statusCode, message: $debugMessage)';
}