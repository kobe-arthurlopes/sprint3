import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/all_articles_item.dart';

class AllArticlesList extends StatelessWidget {
  final List<ArticleModel> articles;
  final bool isScrollable;

  const AllArticlesList({
    super.key,
    required this.articles,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.isEmpty ? 10 : articles.length,
      shrinkWrap: true,
      physics: isScrollable
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AllArticlesItem(
          article: articles.isEmpty ? null : articles[index]
        );
      },
    );
  }
}
