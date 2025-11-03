import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/dao/banner_dao_model.dart';
import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/dao/news_source_dao_model.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/dao/article_dao_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';
import 'package:sprint3_app/models/dto/dto_protocol.dart';
import 'package:sprint3_app/models/dto/dto_type.dart';
import 'package:sprint3_app/models/dto/home_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';
import 'package:sprint3_app/models/sqlite/news_source_sqlite_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/app_preferences.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<ArticleDTOModel> articles;
  List<NewsSourceDTOModel> newsSources;
  List<BannerDTOModel> banners;

  HomeData({
    required this.articles,
    required this.newsSources,
    required this.banners,
  });

  HomeData copyWith({
    List<ArticleDTOModel>? articles,
    List<NewsSourceDTOModel>? newsSources,
    List<BannerDTOModel>? banners,
  }) {
    return HomeData(
      articles: articles ?? this.articles,
      newsSources: newsSources ?? this.newsSources,
      banners: banners ?? this.banners,
    );
  }
}

class HomeViewModel {
  late final CmsConnectionProtocol _cmsConnection;
  late final ApiServiceProtocol _apiService;
  late final ArticleDAOModel _articleDao;
  late final NewsSourceDAOModel _newsSourceDao;
  late final BannerDAOModel _bannerDao;

  final ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(
      articles: [],
      newsSources: [],
      banners: [],
    ),
  );

  Map<String, dynamic>? _requestProperties = {'category': 'general'};

  Future<void> start() async {
    final tokenProvider = await TokenProvider.create();

    _cmsConnection = CmsConnection();
    _cmsConnection.initClient(
      accessToken: tokenProvider.accessTokenCDA, 
      spaceId: tokenProvider.spaceIdCDA
    );

    _apiService = ApiService(apiKey: tokenProvider.newsApiKey);

    final appDatabase = AppDatabase.instance;

    _articleDao = ArticleDAOModel(dbProvider: appDatabase);
    _newsSourceDao = NewsSourceDAOModel(dbProvider: appDatabase);
    _bannerDao = BannerDAOModel(dbProvider: appDatabase);
  }

  Future<void> clearAll() async {
    await _articleDao.clear();
    await _newsSourceDao.clear();
    await _bannerDao.clear();
    await AppPreferences.isFirstEntry.set(true);
  }

  Future<void> fetchObjects() async {
    bool isFirstEntry = await AppPreferences.isFirstEntry.get();

    if (isFirstEntry) {
      await _setObjects(fromSqlite: false);
      AppPreferences.isFirstEntry.set(false);
      return;
    }

    await _setObjects(fromSqlite: true);
  }

  Future<void> _setObjects({bool fromSqlite = true}) async {
    final articles = await _fetchArticles(fromSqlite: fromSqlite);

    final data = await _fetchNewsSourcesAndBanners(fromSqlite: fromSqlite);
    final newsSources = data.newsSources;
    final banners = data.banners;

    homeData.value = homeData.value.copyWith(
      articles: articles,
      newsSources: newsSources,
      banners: banners
    );

    if (!fromSqlite) {
      _persistObjects<ArticleDTOModel>(_articleDao, DtoType.article);
      _persistObjects<NewsSourceDTOModel>(_newsSourceDao, DtoType.newsSource);
      _persistObjects<BannerDTOModel>(_bannerDao, DtoType.banner);
    }
  }

  Future<List<D>> _fetchObjectsFromSqlite<D extends DtoProtocol<S>, S>(
    DaoProtocol dao,
    D Function(S sqliteModel) fromSqlite
  ) async {
    final objectsSqlite = await dao.fetchAll() as List<S>;
    return objectsSqlite.map((element) => fromSqlite(element)).toList();
  }

  Future<List<ArticleDTOModel>> _fetchArticles({bool fromSqlite = true}) async {
    if (fromSqlite) {
      final articles = await _fetchObjectsFromSqlite<ArticleDTOModel, ArticleSqliteModel>(
        _articleDao, 
        ArticleDTOModel.fromSqlite
      );

      return articles;
    }

    try {
      final articleResponse = await _apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson,
        properties: _requestProperties
      );

      return articleResponse.articles;
    } on Exception {
      rethrow;
    }
  }

  Future<({List<NewsSourceDTOModel> newsSources, List<BannerDTOModel> banners})> _fetchNewsSourcesAndBanners({
    bool fromSqlite = true
  }) async {
    List<NewsSourceDTOModel> newsSources = [];
    List<BannerDTOModel> banners = [];

    if (fromSqlite) {
      newsSources = await _fetchObjectsFromSqlite<NewsSourceDTOModel, NewsSourceSqliteModel>(
        _newsSourceDao, 
        NewsSourceDTOModel.fromSqlite
      );

      banners = await _fetchObjectsFromSqlite(
        _bannerDao, 
        BannerDTOModel.fromSqlite
      );
    }

    try {
      HomeCMSModel.registerChildren();
      final HomeCMSModel homeCMS = await _cmsConnection.findAll();
      final homeDTO = HomeDTOModel.fromCMS(homeCMS);

      final carouselDTO = homeDTO.carousel;

      newsSources = NewsSourceDTOModel.getActiveNewsSources(carouselDTO.newsSources);

      banners = BannerDTOModel.getActiveBanners(homeDTO.banners);
    } on Exception {
      rethrow;
    }

    return (newsSources: newsSources, banners: banners);
  }

  Future<void> _persistObjects<T extends DtoProtocol>(
    DaoProtocol dao,
    DtoType dtoType
  ) async {
    await dao.clear();

    final objects = _getObjects<T>(dtoType);

    for (final object in objects) {
      final objectSqlite = object.toSqlite();
      await dao.insert(objectSqlite);
    }
  }

  List<T> _getObjects<T extends DtoProtocol>(DtoType dtoType) {
    switch (dtoType) {
      case DtoType.article:
        return homeData.value.articles as List<T>;
      case DtoType.newsSource:
        return homeData.value.newsSources as List<T>;
      case DtoType.banner:
        return homeData.value.banners as List<T>;
    }
  }

  Future<void> updateSelectedNewsSource(NewsSourceDTOModel newsSource) async {
    if (newsSource.articles.isNotEmpty) {
      return;
    }

    _requestProperties = {'sources': newsSource.sourceId};

    final newsSources = homeData.value.newsSources;
    final index = newsSources.indexWhere((element) => element == newsSource);
    final articles = await _fetchArticles(fromSqlite: false);
    newsSources[index].articles.addAll(articles);

    homeData.value = homeData.value.copyWith(newsSources: newsSources);
  }

  void resetSelectedNewsSource() {
    _requestProperties = {'category': 'general'};
  }
}