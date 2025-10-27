import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/all_articles_item.dart';

class AllArticlesList extends StatelessWidget {
  final List<ArticleModel> articles;
  final bool isScrollable;
  final void Function(ArticleModel)? onTap;

  const AllArticlesList({
    super.key, 
    required this.articles, 
    this.isScrollable = true,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: isScrollable ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final article = articles[index];
    
        return AllArticlesItem(
          article: article,
          onTap: () {
            if (onTap != null) {
              onTap!(article);
            }
          },
        );
      },
    );
  }
}