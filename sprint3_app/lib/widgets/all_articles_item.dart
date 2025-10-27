import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';

class AllArticlesItem extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const AllArticlesItem({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = Size(150, 150);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: article.urlToImage != null
                ? Image.network(
                  article.urlToImage!,
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                )
                : Image.asset(
                  'images/article_img_placeholder.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                )
            ),
        
            SizedBox(width: 10),
        
            Expanded(
              child: SizedBox(
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 8),
        
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.left,
                    ),
                
                    Text(
                      article.author,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300
                      ),
                      maxLines: 2,
                    ),
        
                    SizedBox(height: 8)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}