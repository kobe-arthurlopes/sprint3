import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sprint3_app/service/api/api_exception.dart';
import 'package:sprint3_app/service/api/api_service_protocol.dart';

class ApiMockService implements ApiServiceProtocol {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.genderize.io?name=luc'));

  @override
  Future<T> fetchResponse<T>({
    String endpoint = 'top-headlines', 
    required T Function(Map<String, dynamic>) fromJson, 
    Map<String, dynamic>? properties
  }) async {
    final category = properties?['category'] as String?;
    final sourceId = properties?['sources'] as String?;

    if (category == null && sourceId == null) {
      throw ApiException(
        userMessage: 'Wrong request. Try again.', 
        debugMessage: 'category and sources cannot be both null'
      );
    }

    if (category != null && sourceId != null) {
      throw ApiException(
        userMessage: 'Wrong request. Try again.', 
        debugMessage: 'category and sources cannot be both not null'
      );
    }

    final firstName = (category != null) ? category : formatName(sourceId);
    final fileName = '${firstName}_response.json';

    try {
      final _ = await dio.get('', queryParameters: {'name': 'luc'});

      final jsonString = await rootBundle.loadString('lib/json/$fileName');
      final data = json.decode(jsonString);
      return fromJson(data);
    } on DioException catch (dioError) {
      throw ApiException(
        userMessage: 'Unable to connect. Please check your internet connection and try again. Status code: ${dioError.response?.statusCode}', 
        debugMessage: 'Connection error: ${dioError.message}; No status code found.'
      );
    } catch (error) {
      throw ApiException(
        userMessage: 'Error parsing json', 
        debugMessage: 'Error parsing json'
      );
    }
  }

  String formatName(String? name) {
    return name != null ? name.replaceAll('-', '_') : '';
  }
}