import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source_dto_model.dart';
import 'package:sprint3_app/widgets/shimmer_widget.dart';

class NewsSourceItem extends StatelessWidget {
  final NewsSourceDTOModel? newsSource;
  final VoidCallback? onTap;

  const NewsSourceItem({super.key, required this.newsSource, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null && newsSource != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          right: 5,
          left: 5
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            newsSource == null
              ? ShimmerWidget.circular(radius: 50)
              : ClipOval(
                child: Image.network(
                  newsSource!.logoUrl ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Image.asset(
                      'images/article_img_placeholder.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

            SizedBox(
              width: 100,
              height: 40,
              child: newsSource == null
                ? ShimmerWidget.rectangular()
                : Center(
                  child: Text(
                    newsSource!.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),
            )
          ],
        ),
      ),
    );
  }
}