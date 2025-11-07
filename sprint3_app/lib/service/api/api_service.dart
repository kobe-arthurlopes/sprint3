import 'package:dio/dio.dart';
import 'package:sprint3_app/service/api/api_exception.dart';
import 'package:sprint3_app/service/api/api_service_protocol.dart';

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