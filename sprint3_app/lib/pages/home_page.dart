import 'package:flutter/material.dart';
import 'package:sprint3_app/pages/details_page.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';
import 'package:sprint3_app/widgets/news_sources_list.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';

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
    await _viewModel.fetchNewsSources();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData, 
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
          ),
          body: NewsSourcesList(
            newsSources: data.newsSources,
            onTap: (newsSource) {
              _viewModel.updateSelectedNewsSource(newsSource);

              Navigator.of(context).pushNamed(DetailsPage.routeId, arguments: _viewModel);
            },
          ),
        );
      }
    );
  }
}