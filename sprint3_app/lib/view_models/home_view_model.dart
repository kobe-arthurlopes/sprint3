import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/article.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<Article> articles;

  HomeData({required this.articles});

  HomeData copyWith({
    List<Article>? articles
  }) {
    return HomeData(articles: articles ?? this.articles);
  }
}

class HomeViewModel {
  late final TokenProvider _tokens;
  late final CmsConnection _cmsConnection;
  late final ApiService _apiService;

  ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(articles: [])
  );

  Future<void> start() async {
    _tokens = await TokenProvider.create();

    _cmsConnection = CmsConnection(
      accessToken: _tokens.contentfulAccessToken,
      spaceId: _tokens.contentfulSpaceId,
    );

    _apiService = ApiService(apiKey: _tokens.apiKey);
  }

  Future<void> fetchArticles() async {
    try {
      final articleResponse = await _apiService.fetchArticles();
      final articles = articleResponse.articles;


      homeData.value = homeData.value.copyWith(articles: articles);
    } on Exception {
      rethrow;
    }
  }
}