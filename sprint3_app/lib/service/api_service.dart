import 'package:dio/dio.dart';

abstract class ApiServiceProtocol {
  Future<T> fetchResponse<T>(
    String endpoint, 
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  );
}

class ApiService implements ApiServiceProtocol {
  final String? apiKey;
  final dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  ApiService({required this.apiKey});

  @override
  Future<T> fetchResponse<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  ) async {
    if (apiKey == null) {
      throw Exception;
    }

    properties?['apiKey'] = apiKey;

    try {
      final response = await dio.get(
        endpoint,
        queryParameters: properties,
      );

      return fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }
}