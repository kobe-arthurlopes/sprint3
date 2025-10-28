import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/pages/news_source_details_page.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';
import 'package:sprint3_app/widgets/all_articles_list.dart';
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
    await _viewModel.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData,
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('News')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Top News Sources',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                NewsSourcesList(
                  newsSources: data.newsSources,
                  onTap: (newsSource) async {
                    _viewModel.updateSelectedNewsSource(newsSource);
                    await _viewModel.fetchArticles();

                    final List<ArticleModel> articles =
                        _viewModel.homeData.value.articles;

                    final result = await Navigator.of(context).pushNamed(
                      NewsSourceDetailsPage.routeId,
                      arguments: [newsSource.fields?.name ?? 'empty', articles],
                    );

                    _viewModel.resetSelectedNewsSource();
                    await _viewModel.fetchArticles();
                  },
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Top Headlines',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 8),

                      AllArticlesList(
                        articles: data.articles,
                        isScrollable: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
