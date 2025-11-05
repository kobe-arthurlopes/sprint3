import 'package:sprint3_app/models/dto/article_dto_model.dart';

class NewsSourceDetailsData {
  List<ArticleDTOModel> articles;
  String? errorMessage;

  NewsSourceDetailsData({
    this.articles = const [],
    this.errorMessage,
  });

  NewsSourceDetailsData copyWith({
    List<ArticleDTOModel>? articles,
    String? errorMessage,
  }) {
    return NewsSourceDetailsData(
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}