import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/components/article_tile.dart';

class ArticlesList extends StatelessWidget {
  final List<ArticleDTO> articles;
  final bool isScrollable;
  final bool shouldStartTimeout;

  const ArticlesList({
    super.key,
    required this.articles,
    this.isScrollable = true,
    this.shouldStartTimeout = true
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
        return ArticleTile(
          article: articles.isEmpty ? null : articles[index],
          shouldStartTimeout: shouldStartTimeout,
        );
      },
    );
  }
}
