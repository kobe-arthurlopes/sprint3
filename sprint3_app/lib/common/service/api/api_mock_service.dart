import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sprint3_app/common/service/api/api_exception.dart';
import 'package:sprint3_app/common/service/api/api_service_protocol.dart';
import 'package:sprint3_app/common/service/internet_connection.dart';

class ApiMockService implements ApiServiceProtocol {
  final InternetConnectionChecker internetConnectionChecker;

  ApiMockService({required this.internetConnectionChecker});

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

    final hasInternet = await internetConnectionChecker.hasInternet();

    if (!hasInternet) {
      throw ApiException(
        userMessage: 'Unable to connect. Please check your internet connection and try again.', 
        debugMessage: 'Unable to connect. Please check your internet connection and try again.'
      );
    }

    try {
      final jsonString = await rootBundle.loadString('lib/json/$fileName');
      final data = json.decode(jsonString);
      return fromJson(data);
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