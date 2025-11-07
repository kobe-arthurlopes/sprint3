import 'package:sprint3_app/news_source_details/data/data_sources/news_source_details_local_data_source.dart';
import 'package:sprint3_app/news_source_details/data/data_sources/news_source_details_remote_data_source.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';
import 'package:sprint3_app/common/service/app_cache_manager.dart';
import 'package:sprint3_app/common/service/internet_connection.dart';

class NewsSourceDetailsRepository {
  final NewsSourceDetailsLocalDataSource local;
  final NewsSourceDetailsRemoteDataSource remote;
  final AppCacheManager cacheManager;
  final InternetConnectionChecker internetConnectionChecker;

  NewsSourceDetailsRepository({
    required this.local,
    required this.remote,
    required this.cacheManager,
    required this.internetConnectionChecker,
  });

  Future<NewsSourceDetailsData> fetchData() async {
    final localData = await local.fetch();
    final isEmpty = localData.articles.isEmpty;

    if (isEmpty) {
      final remoteData = await remote.fetch();

      if (!remoteData.isEmpty) {
        _clearAndPersist(remoteData);
      }

      return remoteData;
    }

    return localData;
  }

  Future<void> _clearAndPersist(NewsSourceDetailsData data) async {
    Future.wait([clearAll(data), _persist(data), _cacheImages(data)]);
  }

  Future<void> clearAll(NewsSourceDetailsData data) async {
    await local.deleteAll();
    final urls = data.articles.map((element) => element.urlToImage).toList();
    await cacheManager.clearFiles(urls);
  }

  Future<void> _persist(NewsSourceDetailsData data) async {
    for (final article in data.articles) {
      final articleSqlite = article.toSqlite();
      await local.articleDao.insert(articleSqlite);
    }
  }

  Future<void> _cacheImages(NewsSourceDetailsData data) async {
    final urls = data.articles.map((element) => element.urlToImage).toList();
    await cacheManager.cacheImages(urls);
  }

  Future<bool> hasInternet() async {
    return await internetConnectionChecker.hasInternet();
  }
}
