import 'package:sprint3_app/common/models/dto/article_dto.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';
import 'package:sprint3_app/common/service/api/api_exception.dart';
import 'package:sprint3_app/common/service/api/api_service_protocol.dart';

class NewsSourceDetailsRemoteDataSource {
  final ApiServiceProtocol apiService;
  String? sourceId;

  NewsSourceDetailsRemoteDataSource({
    required this.apiService,
    this.sourceId
  });

  Future<NewsSourceDetailsData> fetch() async {
    try {
      final articleResponse = await apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson,
        properties: {'sources': sourceId}
      );

      return NewsSourceDetailsData(articles: articleResponse.articles);
    } on ApiException catch (error) {
      return NewsSourceDetailsData(errorMessage: error.userMessage);
    }
  }
}