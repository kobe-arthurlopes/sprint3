import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/widgets/all_articles_item.dart';

class AllArticlesList extends StatelessWidget {
  final List<ArticleModel> articles;
  final void Function(ArticleModel)? onTap;

  const AllArticlesList({super.key, required this.articles, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Headlines',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(height: 8),

        ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
        )
      ],
    );
  }
}