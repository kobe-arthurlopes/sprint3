import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';
import 'package:sprint3_app/widgets/all_articles_list.dart';

class NewsSourceDetailsPage extends StatefulWidget {
  static const routeId = '/news_source_details';

  final HomeViewModel viewModel;

  const NewsSourceDetailsPage({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => _NewsSourceDetailsPageState();
}

class _NewsSourceDetailsPageState extends State<NewsSourceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: widget.viewModel.homeData,
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(data.selectedNewsSource?.fields?.name ?? 'empty'),
            leading: IconButton(
              onPressed: () {
                widget.viewModel.fetchAllArticles();

                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10
            ),
            child: AllArticlesList(
              articles: data.articles,
              onTap: (article) {
                print(article.title);
              },
            ),
          ),
        );
      },
    );
  }
}