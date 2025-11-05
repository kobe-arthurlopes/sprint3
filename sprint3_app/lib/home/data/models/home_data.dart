import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';

class HomeData {
  List<NewsSourceDTOModel> newsSources;
  List<BannerDTOModel> banners;
  List<ArticleDTOModel> articles;

  HomeData({
    this.newsSources = const [],
    this.banners = const [],
    this.articles = const [],
  });

  HomeData copyWith({
    List<NewsSourceDTOModel>? newsSources,
    List<BannerDTOModel>? banners,
    List<ArticleDTOModel>? articles,
  }) {
    return HomeData(
      newsSources: newsSources ?? this.newsSources,
      banners: banners ?? this.banners,
      articles: articles ?? this.articles,
    );
  }
}