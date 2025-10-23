import 'package:dio/dio.dart';
import 'package:sprint3_app/models/article.dart';

class ApiService {
  final String? apiKey;

  ApiService({required this.apiKey});

  final _dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  Future<ArticleResponse> fetchArticles() async {
    if (apiKey == null) {
      throw Exception;
    }

    Map<String, dynamic> queryParameters = {'apiKey': apiKey!, 'country': 'us'};

    try {
      final response = await _dio.get(
        'top-headlines',
        queryParameters: queryParameters,
      );

      return ArticleResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }
}
