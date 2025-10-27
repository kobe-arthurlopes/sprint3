import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source_model.dart';
import 'package:sprint3_app/widgets/news_source_item.dart';

class NewsSourcesList extends StatelessWidget {
  final List<NewsSourceModel> newsSources;
  final void Function(NewsSourceModel)? onTap;

  const NewsSourcesList({super.key, required this.newsSources, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top News Sources',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsSources.length,
            itemBuilder: (context, index) {
              final newsSource = newsSources[index];
        
              return NewsSourceItem(
                newsSource: newsSource,
                onTap: () {
                  if (onTap != null) {
                    onTap!(newsSource);
                  }
                },
              );
            }
          ),
        ),
      ],
    );
  }
}