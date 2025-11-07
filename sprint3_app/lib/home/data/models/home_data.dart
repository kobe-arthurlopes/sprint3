import 'package:sprint3_app/common/models/dto/article_dto.dart';
import 'package:sprint3_app/common/models/dto/banner_dto.dart';
import 'package:sprint3_app/common/models/dto/news_source_dto.dart';

class HomeData {
  List<NewsSourceDTO> newsSources;
  List<BannerDTO> banners;
  List<ArticleDTO> articles;
  String? errorMessage;
  bool isLoading;
  bool shouldStartImagesTimeout;

  HomeData({
    this.newsSources = const [],
    this.banners = const [],
    this.articles = const [],
    this.errorMessage,
    this.isLoading = false,
    this.shouldStartImagesTimeout = false
  });

  HomeData copyWith({
    List<NewsSourceDTO>? newsSources,
    List<BannerDTO>? banners,
    List<ArticleDTO>? articles,
    String? errorMessage,
    bool? isLoading,
    bool? shouldStartImagesTimeout,
  }) {
    return HomeData(
      newsSources: newsSources ?? this.newsSources,
      banners: banners ?? this.banners,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      shouldStartImagesTimeout: shouldStartImagesTimeout ?? this.shouldStartImagesTimeout,
    );
  }

  bool get isEmpty => newsSources.isEmpty && banners.isEmpty && articles.isEmpty;
}