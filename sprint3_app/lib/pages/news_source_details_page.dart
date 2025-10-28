import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/all_articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatefulWidget {
  static const routeId = '/news_source_details';

  final String title;
  final List<ArticleModel> articles;

  const NewsSourceDetailsPage({
    super.key,
    required this.title,
    required this.articles,
  });

  @override
  State<StatefulWidget> createState() => _NewsSourceDetailsPageState();
}

class _NewsSourceDetailsPageState extends State<NewsSourceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBarWidget(
        title: widget.title,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10
        ),
        child: AllArticlesList(
          articles: widget.articles,
        ),
      ),
    );
  }
}