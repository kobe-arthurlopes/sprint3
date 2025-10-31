import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/models/dao/banner_dao_model.dart';
import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/dao/news_source_dao_model.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/dao/article_dao_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';
import 'package:sprint3_app/models/dto/home_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';

class HomeData {
  List<ArticleDTOModel> articles;
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
    List<ArticleDTOModel>? articles,
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
  late final CmsConnectionProtocol _cmsConnection;
  late final ApiServiceProtocol _apiService;
  late final ArticleDAOModel _articleDao;
  late final NewsSourceDAOModel _newsSourceDao;
  late final BannerDAOModel _bannerDao;

  final ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(
      articles: [],
      newsSources: [],
      selectedNewsSource: null,
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
  }

  Future<void> fetchObjects() async {
    await _fetchArticlesFromSql();

    if (homeData.value.articles.isEmpty) {
      await fetchArticles();
    }

    await _fetchNewsSourcesFromSql();
    await _fetchBannersFromSql();

    if (homeData.value.newsSources.isEmpty || homeData.value.banners.isEmpty) {
      await _fetchNewsSources();
    }
  }

  Future<void> fetchArticles() async {
    try {
      final articleResponse = await _apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson, 
        properties: _requestProperties
      );

      final articles = articleResponse.articles;
      homeData.value = homeData.value.copyWith(articles: articles);

      await _persistArticles();
    } on Exception {
      rethrow;
    }
  }

  Future<void> _persistArticles() async {
    await _articleDao.clear();

    final articles = homeData.value.articles;

    for (final article in articles) {
      final articleSqlite = article.toSqlite();
      await _articleDao.insert(articleSqlite);
    }
  }

  Future<void> _fetchNewsSources() async {
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

      await _persistNewsSources();
      await _persistBanners();
    } on Exception {
      rethrow;
    }
  }

  Future<void> _persistNewsSources() async {
    await _newsSourceDao.clear();

    final newsSources = homeData.value.newsSources;

    for (final newsSource in newsSources) {
      final newsSourceSqlite = newsSource.toSqlite();
      await _newsSourceDao.insert(newsSourceSqlite);
    }
  }

  Future<void> _persistBanners() async {
    await _bannerDao.clear();

    final banners = homeData.value.banners;

    for (final banner in banners) {
      final bannerSqlite = banner.toSqlite();
      await _bannerDao.insert(bannerSqlite);
    }
  }

  Future<void> _fetchArticlesFromSql() async {
    final articlesSqlite = await _articleDao.fetchAll();
    final articles = articlesSqlite.map((element) => ArticleDTOModel.fromSqlite(element)).toList();
    homeData.value = homeData.value.copyWith(articles: articles);
  }

  Future<void> _fetchNewsSourcesFromSql() async {
    final newsSourcesSqlite = await _newsSourceDao.fetchAll();
    final newsSources = newsSourcesSqlite.map((element) => NewsSourceDTOModel.fromSqlite(element)).toList();
    homeData.value = homeData.value.copyWith(newsSources: newsSources);
  }

  Future<void> _fetchBannersFromSql() async {
    final bannersSqlite = await _bannerDao.fetchAll();
    final banners = bannersSqlite.map((element) => BannerDTOModel.fromSqlite(element)).toList();
    homeData.value = homeData.value.copyWith(banners: banners);
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
