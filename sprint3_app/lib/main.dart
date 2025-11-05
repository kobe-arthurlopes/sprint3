import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/home/data/data_sources/home_local_data_source.dart';
import 'package:sprint3_app/home/data/data_sources/home_remote_data_source.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';
import 'package:sprint3_app/models/dao/article_dao.dart';
import 'package:sprint3_app/models/dao/banner_dao.dart';
import 'package:sprint3_app/models/dao/news_source_dao.dart';
import 'package:sprint3_app/models/dto/banner_dto.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';
import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/news_source_details/data/data_sources/news_source_details_local_data_source.dart';
import 'package:sprint3_app/news_source_details/data/data_sources/news_source_details_remote_data_source.dart';
import 'package:sprint3_app/news_source_details/data/repositories/news_source_details_repository.dart';
import 'package:sprint3_app/home/presentation/pages/banner_details_page.dart';
import 'package:sprint3_app/news_source_details/presentation/pages/news_source_details_page.dart';
import 'package:sprint3_app/home/presentation/pages/home_page.dart';
import 'package:sprint3_app/web_view/data/data_sources/web_view_data_source.dart';
import 'package:sprint3_app/web_view/data/repositories/web_view_repository.dart';
import 'package:sprint3_app/web_view/presentation/pages/web_view_page.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';
import 'package:sprint3_app/home/presentation/view_models/home_view_model.dart';
import 'package:sprint3_app/news_source_details/presentation/view_models/news_source_details_view_model.dart';
import 'package:sprint3_app/web_view/presentation/view_models/web_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenProvider = await TokenProvider.create();

  final apiService = ApiService(apiKey: tokenProvider.newsApiKey);
  final cmsConnection = CmsConnection()
    ..initClient(
      accessToken: tokenProvider.accessTokenCDA,
      spaceId: tokenProvider.spaceIdCDA,
    );

  final appDatabase = AppDatabase.instance;
  final articleDao = ArticleDAO(dbProvider: appDatabase);
  final newsSourceDao = NewsSourceDAO(dbProvider: appDatabase);
  final bannerDao = BannerDAO(dbProvider: appDatabase);

  final homeLocalDataSource = HomeLocalDataSource(
    articleDao: articleDao,
    newsSourceDao: newsSourceDao,
    bannerDao: bannerDao,
  );

  final homeRemoteDataSource = HomeRemoteDataSource(
    apiService: apiService,
    cmsConnection: cmsConnection,
  );

  final appCacheManager = AppCacheManager();

  final homeRepository = HomeRepository(
    local: homeLocalDataSource,
    remote: homeRemoteDataSource,
    cacheManager: appCacheManager,
  );

  final newsSourceDetailsLocalDataSource = NewsSourceDetailsLocalDataSource(articleDao: articleDao);
  final newsSourceDetailsRemoteDataSource = NewsSourceDetailsRemoteDataSource(apiService: apiService);

  final newsSourceDetailsRepository = NewsSourceDetailsRepository(
    local: newsSourceDetailsLocalDataSource, 
    remote: newsSourceDetailsRemoteDataSource, 
    cacheManager: appCacheManager
  );

  final webViewDataSource = WebViewDataSource();
  final webViewRespository = WebViewRepository(dataSource: webViewDataSource);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: apiService),
        Provider.value(value: articleDao),
        Provider.value(value: homeRepository),
        Provider<HomeViewModel>(
          create: (_) => HomeViewModel(repository: homeRepository),
        ),
        Provider<NewsSourceDetailsViewModel>(
          create: (_) => NewsSourceDetailsViewModel(repository: newsSourceDetailsRepository),
        ),
        Provider<WebViewModel>(
          create: (_) => WebViewModel(repository: webViewRespository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (settings) => _onGenerateRoute(context, settings),
      home: const HomePage(),
    );
  }

  Route<dynamic>? _onGenerateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case HomePage.routeId:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );

      case NewsSourceDetailsPage.routeId:
        final newsSource = settings.arguments as NewsSourceDTO;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NewsSourceDetailsPage(newsSource: newsSource),
        );

      case WebViewPage.routeId:
        final url = settings.arguments as String?;

        return MaterialPageRoute(
          builder: (_) => WebViewPage(url: url),
        );

      case BannerDetailsPage.routeId:
        final banner = settings.arguments as BannerDTO;

        return MaterialPageRoute(
          builder: (_) => BannerDetailsPage(banner: banner),
        );

      default:
        return null;
    }
  }
}