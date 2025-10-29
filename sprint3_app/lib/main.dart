import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/models/banner_dto_model.dart';
import 'package:sprint3_app/pages/banner_details_page.dart';
import 'package:sprint3_app/pages/news_source_details_page.dart';
import 'package:sprint3_app/pages/home_page.dart';
import 'package:sprint3_app/pages/webview_page.dart';

void main() {
  runApp(const MyApp());
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
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case HomePage.routeId:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) => HomePage(),
            );
          case NewsSourceDetailsPage.routeId:
            final List<dynamic> arguments =
                routeSettings.arguments as List<dynamic>;

            final String title = arguments[0] as String;
            List<ArticleModel> articles = [];

            if (arguments[1] is List<ArticleModel>) {
              articles = arguments[1] as List<ArticleModel>;
            }

            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) {
                return NewsSourceDetailsPage(title: title, articles: articles);
              },
            );
          case WebviewPage.routeId:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) {
                return WebviewPage(url: routeSettings.arguments as String?);
              },
            );
          case BannerDetailsPage.routId:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) => BannerDetailsPage(
                banner: routeSettings.arguments as BannerDTOModel
              ),
            );
          default:
            return null;
        }
      },
      home: const HomePage(),
    );
  }
}
