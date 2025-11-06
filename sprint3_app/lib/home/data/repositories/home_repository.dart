import 'dart:async';
import 'package:sprint3_app/home/data/data_sources/home_local_data_source.dart';
import 'package:sprint3_app/home/data/data_sources/home_remote_data_source.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';

class HomeRepository {
  final HomeLocalDataSource local;
  final HomeRemoteDataSource remote;
  final AppCacheManager cacheManager;

  HomeRepository({
    required this.local,
    required this.remote,
    required this.cacheManager,
  });

  Future<HomeData> fetchData() async {
    final localData = await local.fetch();
    final isEmpty = localData.isEmpty;

    if (isEmpty) {
      final remoteData = await remote.fetch();

      await _clearAndPersist(remoteData);
      // unawaited(_clearAndPersist(remoteData));

      return remoteData;
    }

    return localData;
  }

  Future<void> _clearAndPersist(HomeData data) async {
    await Future.wait([clearAll(), _persist(data), _cacheImages(data)]);
  }

  Future<void> clearAll({bool includingChildren = false}) async {
    await local.deleteAll(includingChildren: includingChildren);
    await cacheManager.clear();
  }

  Future<void> _persist(HomeData data) async {
    for (final newsSource in data.newsSources) {
      final newsSourceSqlite = newsSource.toSqlite();
      await local.newsSourceDao.insert(newsSourceSqlite);
    }

    for (final banner in data.banners) {
      final bannerSqlite = banner.toSqlite();
      await local.bannerDao.insert(bannerSqlite);
    }

    for (final article in data.articles) {
      final articleSqlite = article.toSqlite(forcedCategory: 'general');
      await local.articleDao.insert(articleSqlite);
    }
  }

  Future<void> _cacheImages(HomeData data) async {
    final urls = [
      ...data.newsSources.map((element) => element.logoUrl),
      ...data.banners.map((element) => element.logoUrl),
      ...data.articles.map((element) => element.urlToImage),
    ];

    await cacheManager.cacheImages(urls);
  }
}
