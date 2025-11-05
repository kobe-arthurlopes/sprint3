import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/models/dto/banner_dto.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';

class HomeData {
  List<NewsSourceDTO> newsSources;
  List<BannerDTO> banners;
  List<ArticleDTO> articles;
  String? errorMessage;

  HomeData({
    this.newsSources = const [],
    this.banners = const [],
    this.articles = const [],
    this.errorMessage
  });

  HomeData copyWith({
    List<NewsSourceDTO>? newsSources,
    List<BannerDTO>? banners,
    List<ArticleDTO>? articles,
    String? errorMessage,
  }) {
    return HomeData(
      newsSources: newsSources ?? this.newsSources,
      banners: banners ?? this.banners,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isEmpty => newsSources.isEmpty && banners.isEmpty && articles.isEmpty;
}