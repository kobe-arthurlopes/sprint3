import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatelessWidget {
  static const routeId = '/news_source_details';

  final String title;
  final List<ArticleModel> articles;

  const NewsSourceDetailsPage({
    super.key,
    required this.title,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEDEF),
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ArticlesList(articles: articles),
      ),
    );
  }
}
