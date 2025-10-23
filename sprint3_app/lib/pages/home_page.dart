import 'package:flutter/material.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _viewModel.start();
    await _viewModel.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData,
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Articles"),
          ),
          body: ListView.builder(
            itemCount: data.articles.length,
            itemBuilder: (context, index) {
              final article = data.articles[index];

              return ListTile(
                title: Text(article.name),
                subtitle: Text(article.description),
              );
            },
          ),
        );
      },
    );
  }
}