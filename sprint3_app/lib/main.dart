import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/home/data/data_sources/home_local_data_source.dart';
import 'package:sprint3_app/home/data/data_sources/home_remote_data_source.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';
import 'package:sprint3_app/models/dao/article_dao_model.dart';
import 'package:sprint3_app/models/dao/banner_dao_model.dart';
import 'package:sprint3_app/models/dao/news_source_dao_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/pages/banner_details_page.dart';
import 'package:sprint3_app/pages/news_source_details_page.dart';
import 'package:sprint3_app/home/presentation/pages/home_page.dart';
import 'package:sprint3_app/pages/web_view_page.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';
import 'package:sprint3_app/service/cms_connection.dart';
import 'package:sprint3_app/service/token_provider.dart';
import 'package:sprint3_app/home/presentation/view_models/home_view_model.dart';
import 'package:sprint3_app/view_models/news_source_details_view_model.dart';

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
  final articleDao = ArticleDAOModel(dbProvider: appDatabase);
  final newsSourceDao = NewsSourceDAOModel(dbProvider: appDatabase);
  final bannerDao = BannerDAOModel(dbProvider: appDatabase);

  final localDataSource = HomeLocalDataSource(
    articleDao: articleDao,
    newsSourceDao: newsSourceDao,
    bannerDao: bannerDao,
  );

  final remoteDataSource = HomeRemoteDataSource(
    apiService: apiService,
    cmsConnection: cmsConnection,
  );

  final repository = HomeRepository(
    local: localDataSource,
    remote: remoteDataSource,
    cacheManager: AppCacheManager(),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: apiService),
        Provider.value(value: articleDao),
        Provider.value(value: repository),
        Provider<HomeViewModel>(
          create: (_) => HomeViewModel(repository: repository),
        ),
        Provider<NewsSourceDetailsViewModel>(
          create: (_) => NewsSourceDetailsViewModel(
            apiService: apiService,
            articleDao: articleDao,
          ),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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
        final newsSource = settings.arguments as NewsSourceDTOModel;

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
        final banner = settings.arguments as BannerDTOModel;

        return MaterialPageRoute(
          builder: (_) => BannerDetailsPage(banner: banner),
        );

      default:
        return null;
    }
  }
}