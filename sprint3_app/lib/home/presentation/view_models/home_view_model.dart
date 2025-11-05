import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';

class HomeViewModel {
  final HomeRepository repository;
  final ValueNotifier<HomeData> data = ValueNotifier(HomeData());

  HomeViewModel({required this.repository});

  Future<void> start() async {
    final homeData = await repository.fetchHomeData();
    data.value = homeData;
  }

  Future<void> clearAll() async {
    await repository.clearAll();
    data.value = HomeData();
  }
}

// class HomeViewModel {
//   late final CmsConnectionProtocol _cmsConnection;
//   late final ApiServiceProtocol apiService;
//   late final ArticleDAOModel articleDao;
//   late final NewsSourceDAOModel _newsSourceDao;
//   late final BannerDAOModel _bannerDao;

//   final ValueNotifier<HomeData> data = ValueNotifier(
//     HomeData(articles: [], newsSources: [], banners: []),
//   );

  // Future<void> start() async {
  //   final tokenProvider = await TokenProvider.create();

  //   _cmsConnection = CmsConnection();
  //   _cmsConnection.initClient(
  //     accessToken: tokenProvider.accessTokenCDA,
  //     spaceId: tokenProvider.spaceIdCDA,
  //   );

  //   apiService = ApiService(apiKey: tokenProvider.newsApiKey);

  //   final appDatabase = AppDatabase.instance;

  //   articleDao = ArticleDAOModel(dbProvider: appDatabase);
  //   _newsSourceDao = NewsSourceDAOModel(dbProvider: appDatabase);
  //   _bannerDao = BannerDAOModel(dbProvider: appDatabase);
  // }

//   Future<void> clearAll() async {
//     await _newsSourceDao.clear();
//     await _bannerDao.clear();
//     await articleDao.clear();
//     await AppPreferences.isFirstEntry.set(true);
//   }

//   Future<void> fetchObjects() async {
//     bool isFirstEntry = await AppPreferences.isFirstEntry.get();

//     await _setObjects(fromSqlite: !isFirstEntry);

//     if (isFirstEntry) AppPreferences.isFirstEntry.set(false);
//   }

//   Future<void> _setObjects({bool fromSqlite = true}) async {
//     final data = await _fetchNewsSourcesAndBanners(fromSqlite: fromSqlite);
//     final newsSources = data.newsSources;
//     final banners = data.banners;

//     final articles = await _fetchArticles(fromSqlite: fromSqlite);

//     this.data.value = this.data.value.copyWith(
//       newsSources: newsSources,
//       banners: banners,
//       articles: articles,
//     );

//     if (!fromSqlite) {
//       await _persistObjects<NewsSourceDTOModel>(
//         _newsSourceDao,
//         DtoType.newsSource,
//       );

//       await _persistObjects<BannerDTOModel>(_bannerDao, DtoType.banner);

//       await _persistObjects<ArticleDTOModel>(articleDao, DtoType.article);

//       await articleDao.updateField(
//         column: 'category',
//         value: 'general',
//         where: 'category IS NULL',
//       );

//       await _cacheImages();
//     }
//   }

//   Future<List<D>> _fetchObjectsFromSqlite<D extends DtoProtocol<S>, S>({
//     required DaoProtocol dao,
//     required D Function(S sqliteModel) fromSqlite,
//     String? where,
//     List<Object?>? whereArgs,
//   }) async {
//     List<S> objectsSqlite = [];

//     if (where == null && whereArgs == null) {
//       objectsSqlite = await dao.fetchAll() as List<S>;
//     } else {
//       objectsSqlite =
//           await dao.fetchWhere(where: where!, whereArgs: whereArgs!) as List<S>;
//     }

//     return objectsSqlite.map((element) => fromSqlite(element)).toList();
//   }

//   Future<List<ArticleDTOModel>> _fetchArticles({bool fromSqlite = true}) async {
//     if (fromSqlite) {
//       final articles =
//           await _fetchObjectsFromSqlite<ArticleDTOModel, ArticleSqliteModel>(
//             dao: articleDao,
//             fromSqlite: ArticleDTOModel.fromSqlite,
//             where: 'category = ?',
//             whereArgs: ['general'],
//           );

//       return articles;
//     }

//     try {
//       final articleResponse = await apiService.fetchResponse(
//         fromJson: ArticleResponse.fromJson,
//         properties: {'category': 'general'},
//       );

//       return articleResponse.articles;
//     } catch (error) {
//       rethrow;
//     }
//   }

//   Future<({List<NewsSourceDTOModel> newsSources, List<BannerDTOModel> banners})>
//   _fetchNewsSourcesAndBanners({bool fromSqlite = true}) async {
//     List<NewsSourceDTOModel> newsSources = [];
//     List<BannerDTOModel> banners = [];

//     if (fromSqlite) {
//       newsSources =
//           await _fetchObjectsFromSqlite<
//             NewsSourceDTOModel,
//             NewsSourceSqliteModel
//           >(dao: _newsSourceDao, fromSqlite: NewsSourceDTOModel.fromSqlite);

//       banners =
//           await _fetchObjectsFromSqlite<BannerDTOModel, BannerSqliteModel>(
//             dao: _bannerDao,
//             fromSqlite: BannerDTOModel.fromSqlite,
//           );
//     }

//     try {
//       HomeCMSModel.registerChildren();
//       final HomeCMSModel homeCMS = await _cmsConnection.findAll();
//       final homeDTO = HomeDTOModel.fromCMS(homeCMS);

//       final carouselDTO = homeDTO.carousel;

//       newsSources = NewsSourceDTOModel.getActiveNewsSources(
//         carouselDTO.newsSources,
//       );

//       banners = BannerDTOModel.getActiveBanners(homeDTO.banners);
//     } on Exception {
//       rethrow;
//     }

//     return (newsSources: newsSources, banners: banners);
//   }

//   Future<void> _persistObjects<T extends DtoProtocol>(
//     DaoProtocol dao,
//     DtoType dtoType,
//   ) async {
//     await dao.clear();

//     final objects = _getObjects<T>(dtoType);

//     for (final object in objects) {
//       final objectSqlite = object.toSqlite();
//       await dao.insert(objectSqlite);
//     }
//   }

//   Future<void> _cacheImages() async {
//     final newsSources = _getObjects<NewsSourceDTOModel>(DtoType.newsSource);
//     final newsSourceImageUrls = newsSources
//         .map((element) => element.logoUrl)
//         .toList();

//     final banners = _getObjects<BannerDTOModel>(DtoType.banner);
//     final bannerImageUrls = banners.map((element) => element.logoUrl).toList();

//     final articles = _getObjects<ArticleDTOModel>(DtoType.article);
//     final articleImageUrls = articles
//         .map((element) => element.urlToImage)
//         .toList();

//     final List<String?> allImageUrls = [
//       ...newsSourceImageUrls,
//       ...bannerImageUrls,
//       ...articleImageUrls,
//     ];

//     await AppCacheManager().cacheImages(allImageUrls);
//   }

//   List<T> _getObjects<T extends DtoProtocol>(DtoType dtoType) {
//     switch (dtoType) {
//       case DtoType.article:
//         return data.value.articles as List<T>;
//       case DtoType.newsSource:
//         return data.value.newsSources as List<T>;
//       case DtoType.banner:
//         return data.value.banners as List<T>;
//     }
//   }
// }
