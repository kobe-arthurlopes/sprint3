import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 8),

            Text(
              article.description,
              style: TextStyle(
                fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
      ),
    );
  }
}