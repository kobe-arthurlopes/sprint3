import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/models/news_source_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<ArticleModel> articles;
  List<NewsSourceModel> newsSources;
  NewsSourceModel? selectedNewsSource;

  HomeData({
    required this.articles, 
    required this.newsSources,
    required this.selectedNewsSource
  });

  HomeData copyWith({
    List<ArticleModel>? articles,
    List<NewsSourceModel>? newsSources,
    NewsSourceModel? selectedNewsSource,
  }) {
    return HomeData(
      articles: articles ?? this.articles,
      newsSources: newsSources ?? this.newsSources,
      selectedNewsSource: selectedNewsSource ?? this.selectedNewsSource
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
      selectedNewsSource: null
    )
  );

  Map<String, dynamic>? _requestProperties;

  Future<void> start() async {
    _tokens = await TokenProvider.create();

    _cmsConnection = CmsConnection(
      accessToken: _tokens.contentfulAccessToken,
      spaceId: _tokens.contentfulSpaceId,
    );

    _apiService = ApiService(apiKey: _tokens.apiKey);
  }

  Future<void> fetchAllArticles() async {
    _requestProperties = {'category': 'general'};
    await _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      final articles = await _apiService.fetchArticles(_requestProperties);
      homeData.value = homeData.value.copyWith(articles: articles);
    } on Exception {
      rethrow;
    }
  }

  Future<void> fetchNewsSources() async {
    try {
      final newsSources = await _cmsConnection.findAll();
      homeData.value = homeData.value.copyWith(newsSources: newsSources);
    } on Exception {
      rethrow;
    }
  }

  void updateSelectedNewsSource(NewsSourceModel newsSource) {
    homeData.value = homeData.value.copyWith(selectedNewsSource: newsSource);
    _requestProperties = {'sources': newsSource.fields?.sourceId};
    _fetchArticles();
  }
}