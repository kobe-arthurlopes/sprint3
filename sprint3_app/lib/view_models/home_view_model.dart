import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/article.dart';
import 'package:sprint3_app/models/news_source.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<Article> articles;
  List<NewsSource> newsSources;

  HomeData({required this.articles, required this.newsSources});

  HomeData copyWith({
    List<Article>? articles,
    List<NewsSource>? newsSources
  }) {
    return HomeData(
      articles: articles ?? this.articles,
      newsSources: newsSources ?? this.newsSources
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
      newsSources: []
    )
  );

  (String, dynamic)? _queryParameterTuple;

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
      final articleResponse = await _apiService.fetchArticles(_queryParameterTuple);
      homeData.value = homeData.value.copyWith(articles: articleResponse.articles);
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

  void updateQueryParameterTuple(dynamic value) {
    if (value != null) {
      _queryParameterTuple = ('sources', value);
    }
  }
}