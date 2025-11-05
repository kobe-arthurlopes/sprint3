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
      await local.clearAll();
      await _persist(remoteData);
      await _cacheImages(remoteData);
      return remoteData;
    }

    return localData;


    // final isFirstEntry = await AppPreferences.isFirstEntry.get();

    // if (!isFirstEntry) {
    //   return await local.fetch();
    // }

    // final remoteData = await remote.fetch();

    // await local.clearAll();
    // await _persist(remoteData);
    // await _cacheImages(remoteData);

    // await AppPreferences.isFirstEntry.set(false);

    // return remoteData;
  }

  Future<void> clearAll() async {
    await local.clearAll();
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
      final articleSqlite = article.toSqlite();
      await local.articleDao.insert(articleSqlite);
    }

    await local.articleDao.updateField(
      column: 'category',
      value: 'general',
      where: 'category IS NULL',
    );
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
