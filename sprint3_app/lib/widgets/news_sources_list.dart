import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source.dart';
import 'package:sprint3_app/widgets/news_source_item.dart';

class NewsSourcesList extends StatefulWidget {
  final List<NewsSource> newsSources;
  final void Function(String?)? onTap;

  const NewsSourcesList({
    super.key, 
    required this.newsSources,
    this.onTap
  });

  @override
  State<StatefulWidget> createState() => _NewsSourcesListState();
}

class _NewsSourcesListState extends State<NewsSourcesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10
          ),
          child: Text(
            'Top News Sources',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.newsSources.length,
            itemBuilder: (context, index) {
              final newsSource = widget.newsSources[index];
        
              return NewsSourceItem(
                newsSource: newsSource,
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(newsSource.fields?.sourceId);
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