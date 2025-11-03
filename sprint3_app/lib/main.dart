import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/pages/banner_details_page.dart';
import 'package:sprint3_app/pages/news_source_details_page.dart';
import 'package:sprint3_app/pages/home_page.dart';
import 'package:sprint3_app/pages/web_view_page.dart';

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
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) {
                return NewsSourceDetailsPage(newsSource: routeSettings.arguments as NewsSourceDTOModel);
              },
            );
          case WebViewPage.routeId:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) {
                return WebViewPage(url: routeSettings.arguments as String?);
              },
            );
          case BannerDetailsPage.routeId:
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
