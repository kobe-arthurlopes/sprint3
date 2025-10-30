import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source_dto_model.dart';
import 'package:sprint3_app/widgets/news_source_item.dart';

class NewsSourcesList extends StatelessWidget {
  final List<NewsSourceDTOModel> newsSources;
  final void Function(NewsSourceDTOModel)? onTap;

  const NewsSourcesList({super.key, required this.newsSources, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsSources.isEmpty ? 10 : newsSources.length,
        itemBuilder: (context, index) {
          return NewsSourceItem(
            newsSource: newsSources.isEmpty ? null : newsSources[index],
            onTap: () {
              if (onTap != null && newsSources.isNotEmpty) {
                onTap!(newsSources[index]);
              }
            },
          );
        }
      ),
    );
  }
}