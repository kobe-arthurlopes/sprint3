import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/widgets/articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatelessWidget {
  static const routeId = '/news_source_details';

  final NewsSourceDTOModel newsSource;

  const NewsSourceDetailsPage({
    super.key,
    required this.newsSource
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(title: newsSource.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ArticlesList(articles: newsSource.articles),
      ),
    );
  }
}
