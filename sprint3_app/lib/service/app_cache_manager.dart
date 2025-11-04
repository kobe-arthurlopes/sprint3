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
          maxNrOfCacheObjects: 200,
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
}

// class AppCacheManager {
//   static const _key = 'appCache';

//   static final CacheManager _instance = CacheManager(
//     Config(
//       _key,
//       stalePeriod: const Duration(days: 30),
//       maxNrOfCacheObjects: 300,
//       repo: JsonCacheInfoRepository(databaseName: 'AppCacheInfo'),
//       fileService: HttpFileService()
//     )
//   );

//   static CacheManager get instance => _instance;

//   static Future<void> preCacheImages(List<String?> urls) async {
//     for (final url in urls) {
//       if (url == null || url.isEmpty) {
//         continue;
//       }

//       try {
//         await _instance.downloadFile(url);
//       } catch (error) {
//         print(error.toString());
//       }
//     }
//   }

//   static Future<void> clear() async {
//     await _instance.emptyCache();
//   }

//   static Future<FileInfo?> getCachedFile(String url) async {
//     return await _instance.getFileFromCache(url);
//   }

//   static Future<FileInfo?> refreshFile(String url) async {
//     return await _instance.downloadFile(url, force: true);
//   }

//   static CachedNetworkImageProvider provider(String url) {
//     return CachedNetworkImageProvider(url, cacheManager: _instance);
//   }
// }
