import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source.dart';

class NewsSourceItem extends StatelessWidget {
  final NewsSource newsSource;
  final VoidCallback? onTap;

  const NewsSourceItem({
    super.key, 
    required this.newsSource,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                newsSource.fields?.logoUrl ?? 'none'
              ),
            ),
        
            SizedBox(
              width: 100,
              height: 40,
              child: Center(
                child: Text(
                  newsSource.fields?.name ?? 'none',
                  textAlign: TextAlign.center,
                )
              )
            )
          ],
        ),
      ),
    );
  }
}