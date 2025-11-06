import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';
import 'package:sprint3_app/home/presentation/components/news_source_tile.dart';

class NewsSourcesList extends StatelessWidget {
  final List<NewsSourceDTO> newsSources;
  final void Function(NewsSourceDTO)? onTap;
  final bool shouldStartTimeout;

  const NewsSourcesList({super.key, required this.newsSources, this.onTap, this.shouldStartTimeout = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsSources.isEmpty ? 10 : newsSources.length,
        itemBuilder: (context, index) {
          return NewsSourceTile(
            newsSource: newsSources.isEmpty ? null : newsSources[index],
            onTap: () {
              if (onTap != null && newsSources.isNotEmpty) {
                onTap!(newsSources[index]);
              }
            },
            shouldStartTimeout: shouldStartTimeout,
          );
        }
      ),
    );
  }
}