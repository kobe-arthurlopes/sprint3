import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/pages/webview_page.dart';

class AllArticlesItem extends StatelessWidget {
  final ArticleModel article;

  const AllArticlesItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final Size size = Size(150, 150);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                  ),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 4,
                    textAlign: TextAlign.left,
                  ),

                  Text(
                    article.author,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                    maxLines: 2,
                  ),

                  SizedBox(height: 8),

                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          WebviewPage.routeId,
                          arguments: article.url,
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Visit website',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                          SizedBox(width: 4),

                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.open_in_new,
                              color: Colors.blue,
                              size: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
