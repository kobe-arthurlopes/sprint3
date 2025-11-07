import 'dart:async';
import 'package:sprint3_app/home/data/data_sources/home_local_data_source.dart';
import 'package:sprint3_app/home/data/data_sources/home_remote_data_source.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';
import 'package:sprint3_app/service/internet_connection.dart';

class HomeRepository {
  final HomeLocalDataSource local;
  final HomeRemoteDataSource remote;
  final AppCacheManager cacheManager;
  final InternetConnectionChecker internetConnectionChecker;

  HomeRepository({
    required this.local,
    required this.remote,
    required this.cacheManager,
    required this.internetConnectionChecker,
  });

  Future<HomeData> fetchData() async {
    final localData = await local.fetch();
    final isEmpty = localData.isEmpty;

    if (isEmpty) {
      final remoteData = await remote.fetch();

      if (!remoteData.isEmpty) {
        await _clearAndPersist(remoteData);
      } 

      return remoteData;
    }

    return localData;
  }

  Future<void> _clearAndPersist(HomeData data) async {
    await Future.wait([clearAll(data), _persist(data), _cacheImages(data)]);
  }

  Future<void> clearAll(HomeData data, {bool includingChildren = false}) async {
    await local.deleteAll(includingChildren: includingChildren);
    final urls = getUrls(data);
    await cacheManager.clearFiles(urls);
  }

  List<String?> getUrls(HomeData data) {
    final newsSourceUrls = data.newsSources
        .map((element) => element.logoUrl)
        .toList();

    final bannerUrls = data.banners.map((element) => element.logoUrl).toList();

    final articleUrls = data.articles
        .map((element) => element.urlToImage)
        .toList();

    return [...newsSourceUrls, ...bannerUrls, ...articleUrls];
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

  Future<bool> hasInternet() async {
    return await internetConnectionChecker.hasInternet();
  }
}
