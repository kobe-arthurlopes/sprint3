import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';
import 'package:sprint3_app/service/api_service.dart';

class NewsSourceDetailsData {
  List<ArticleDTOModel> articles;
  bool isLoading;
  String? errorMessage;

  NewsSourceDetailsData({
    required this.articles,
    required this.isLoading,
    this.errorMessage
  });

  NewsSourceDetailsData copyWith({
    List<ArticleDTOModel>? articles,
    bool? isLoading,
    String? errorMessage
  }) {
    return NewsSourceDetailsData(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}

class NewsSourceDetailsViewModel {
  final ApiServiceProtocol apiService;
  final DaoProtocol articleDao;
  final String? sourceId;

  NewsSourceDetailsViewModel({
    required this.apiService, 
    required this.articleDao,
    required this.sourceId
  });

  final ValueNotifier<NewsSourceDetailsData> data = ValueNotifier(
    NewsSourceDetailsData(articles: [], isLoading: true, errorMessage: null)
  );

  Future<void> setArticles() async {
    List<ArticleDTOModel> articles = await _fetchArticles(fromSqlite: true);
    final isEmpty = articles.isEmpty;

    if (isEmpty) {
      try {
        articles = await _fetchArticles(fromSqlite: false);
        await _persistArticles(articles);
        data.value = data.value.copyWith(errorMessage: null);
      } on ApiException catch (error) {
        data.value = data.value.copyWith(errorMessage: error.userMessage);
      }
    }

    data.value = data.value.copyWith(articles: articles);
  }

  Future<List<ArticleDTOModel>> _fetchArticles({bool fromSqlite = true}) async {
    if (fromSqlite) {
      final articlesSqlite = await articleDao.fetchWhere(
        where: 'category IS NULL AND sourceId = ?', 
        whereArgs: [sourceId]
      ) as List<ArticleSqliteModel>;

      return articlesSqlite.map((element) => ArticleDTOModel.fromSqlite(element)).toList();
    }

    try {
      final articleResponse = await apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson,
        properties: {'sources': sourceId}
      );

      return articleResponse.articles;
    } on Exception {
      rethrow;
    }
  }

  Future<void> _persistArticles(List<ArticleDTOModel> objects) async {
    for (final object in objects) {
      final objectsSqlite = object.toSqlite();
      await articleDao.insert(objectsSqlite);
    }
  }
}