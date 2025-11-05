import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager {
  static final AppCacheManager _instance = AppCacheManager._internal();
  factory AppCacheManager() => _instance;

  final CacheManager cacheManager;

  AppCacheManager._internal()
    : cacheManager = CacheManager(
        Config(
          'appCache',
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 150,
        ),
      );

  Future<void> cacheImages(List<String?> imageUrls) async {
    for (final url in imageUrls) {
      if (url == null) {
        continue;
      }

      try {
        await cacheManager.downloadFile(url);
      } catch (error) {
        print('Error caching image $url: $error');
      }
    }
  }

  Future<void> clear() async {
    await cacheManager.emptyCache();
  }
}
