import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/all_articles_list.dart';

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
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AllArticlesList(
          articles: widget.articles,
        ),
      ),
    );
  }
}
