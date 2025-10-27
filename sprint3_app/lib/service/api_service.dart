import 'package:dio/dio.dart';
import 'package:sprint3_app/models/article_model.dart';

class ApiService {
  final String? apiKey;

  ApiService({required this.apiKey});

  final _dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org/v2/'));

  Future<List<ArticleModel>> fetchArticles(Map<String, dynamic>? properties) async {
    if (apiKey == null) {
      throw Exception;
    }

    properties?['apiKey'] = apiKey!;

    try {
      final response = await _dio.get(
        'top-headlines',
        queryParameters: properties,
      );

      final ArticleResponse articleResponse = ArticleResponse.fromJson(response.data);
      return articleResponse.articles;
    } on DioException {
      rethrow;
    }
  }
}
