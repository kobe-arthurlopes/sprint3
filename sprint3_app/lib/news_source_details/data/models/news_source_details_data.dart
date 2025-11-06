import 'package:sprint3_app/models/dto/article_dto.dart';

class NewsSourceDetailsData {
  List<ArticleDTO> articles;
  String? errorMessage;

  NewsSourceDetailsData({
    this.articles = const [],
    this.errorMessage,
  });

  NewsSourceDetailsData copyWith({
    List<ArticleDTO>? articles,
    String? errorMessage,
  }) {
    return NewsSourceDetailsData(
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isEmpty => articles.isEmpty;
}