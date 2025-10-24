import 'package:flutter/material.dart';
import 'package:sprint3_app/pages/details_page.dart';
import 'package:sprint3_app/pages/home_page.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';

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
          case DetailsPage.routeId:
            final HomeViewModel viewModel = routeSettings.arguments as HomeViewModel;

            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) => DetailsPage(viewModel: viewModel),
            );
          default:
            return null;
        }
      },
      home: const HomePage(),
    );
  }
}