import 'package:dio/dio.dart';

abstract class ApiServiceProtocol {
  String? get apiKey;
  Dio get dio;

  Future<T> fetchResponse<T>(
    String endpoint, 
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? properties
  );
}