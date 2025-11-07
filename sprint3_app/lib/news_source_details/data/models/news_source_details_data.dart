import 'package:sprint3_app/models/dto/article_dto.dart';

class NewsSourceDetailsData {
  List<ArticleDTO> articles;
  String? errorMessage;
  bool shouldStartImagesTimeout;

  NewsSourceDetailsData({
    this.articles = const [],
    this.errorMessage,
    this.shouldStartImagesTimeout = false
  });

  NewsSourceDetailsData copyWith({
    List<ArticleDTO>? articles,
    String? errorMessage,
    bool? shouldStartImagesTimeout,
  }) {
    return NewsSourceDetailsData(
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
      shouldStartImagesTimeout: shouldStartImagesTimeout ?? this.shouldStartImagesTimeout,
    );
  }

  bool get isEmpty => articles.isEmpty;
}