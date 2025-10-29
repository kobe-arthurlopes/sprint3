import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/models/banner_dto_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';
import 'package:sprint3_app/models/home_dto_model.dart';
import 'package:sprint3_app/models/news_source_dto_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<ArticleModel> articles;
  List<NewsSourceDTOModel> newsSources;
  NewsSourceDTOModel? selectedNewsSource;
  List<BannerDTOModel> banners;

  HomeData({
    required this.articles,
    required this.newsSources,
    required this.selectedNewsSource,
    required this.banners,
  });

  HomeData copyWith({
    List<ArticleModel>? articles,
    List<NewsSourceDTOModel>? newsSources,
    NewsSourceDTOModel? selectedNewsSource,
    List<BannerDTOModel>? banners,
  }) {
    return HomeData(
      articles: articles ?? this.articles,
      newsSources: newsSources ?? this.newsSources,
      selectedNewsSource: selectedNewsSource ?? this.selectedNewsSource,
      banners: banners ?? this.banners,
    );
  }
}

class HomeViewModel {
  late final TokenProvider _tokens;
  late final CmsConnection _cmsConnection;
  late final ApiService _apiService;

  ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(
      articles: [],
      newsSources: [],
      selectedNewsSource: null,
      banners: [],
    ),
  );

  Map<String, dynamic>? _requestProperties = {'category': 'general'};

  Future<void> start() async {
    _tokens = await TokenProvider.create();

    _cmsConnection = CmsConnection(
      accessToken: _tokens.accessTokenCDA,
      spaceId: _tokens.spaceIdCDA,
    );

    _apiService = ApiService(apiKey: _tokens.newsApiKey);
  }

  Future<void> fetchArticles() async {
    try {
      final articles = await _apiService.fetchArticles(_requestProperties);
      homeData.value = homeData.value.copyWith(articles: articles);
    } on Exception {
      rethrow;
    }
  }

  Future<void> fetchNewsSources() async {
    try {
      HomeCMSModel.registerChildren();
      final HomeCMSModel homeCMS = await _cmsConnection.findAll();
      final homeDTO = HomeDTOModel.fromCMS(homeCMS);

      final carouselDTO = homeDTO.carousel;

      List<NewsSourceDTOModel> newsSourcesDTO = carouselDTO.newsSources;
      newsSourcesDTO = NewsSourceDTOModel.getActiveNewsSources(newsSourcesDTO);
      
      List<BannerDTOModel> bannersDTO = homeDTO.banners;
      bannersDTO = BannerDTOModel.getActiveBanners(bannersDTO);

      homeData.value = homeData.value.copyWith(
        newsSources: newsSourcesDTO,
        banners: bannersDTO,
      );
    } on Exception {
      rethrow;
    }
  }

  void updateSelectedNewsSource(NewsSourceDTOModel newsSource) {
    homeData.value = homeData.value.copyWith(selectedNewsSource: newsSource);
    _requestProperties = {'sources': newsSource.sourceId};
  }

  void resetSelectedNewsSource() {
    homeData.value = homeData.value.copyWith(selectedNewsSource: null);
    _requestProperties = {'category': 'general'};
  }
}
