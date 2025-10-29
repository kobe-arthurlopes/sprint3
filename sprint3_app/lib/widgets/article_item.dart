import 'package:flutter/material.dart';
import 'package:sprint3_app/models/article_model.dart';
import 'package:sprint3_app/pages/webview_page.dart';
import 'package:sprint3_app/widgets/shimmer_widget.dart';

class ArticleItem extends StatelessWidget {
  final ArticleModel? article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final Size size = Size(150, 150);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article == null
              ? ShimmerWidget.rectangular(
                  width: size.width,
                  height: size.height,
                  borderRadius: 16,
                )
              : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  article!.urlToImage ?? '',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Image.asset(
                      'images/article_img_placeholder.png',
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover,
                    );
                  },
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

                  article == null
                      ? ShimmerWidget.rectangular(height: 50)
                      : Text(
                          article!.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                          maxLines: 4,
                          textAlign: TextAlign.left,
                        ),

                  article == null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: ShimmerWidget.rectangular(height: 20),
                        )
                      : Text(
                          article!.author,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF6B7280),
                          ),
                          maxLines: 2,
                        ),

                  SizedBox(height: 8),

                  article == null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: ShimmerWidget.rectangular(height: 16),
                        )
                      : Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                WebviewPage.routeId,
                                arguments: article!.url,
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Visit website',
                                  style: TextStyle(
                                    color: Color(0xFF1976D2),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),

                                SizedBox(width: 4),

                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Icon(
                                    Icons.open_in_new,
                                    color: Color(0xFF1976D2),
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
