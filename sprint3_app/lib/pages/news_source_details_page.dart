import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/widgets/articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatelessWidget {
  static const routeId = '/news_source_details';

  final NewsSourceDTOModel newsSource;
  final String? errorMessage;

  const NewsSourceDetailsPage({
    super.key,
    required this.newsSource,
    required this.errorMessage
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(title: newsSource.name),
      body: errorMessage != null
        ? _buildErrorView(errorMessage!)
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ArticlesList(articles: newsSource.articles),
        ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.appBarBackground,
              size: 60,
            ),

            const SizedBox(height: 16),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
              ),
            ),

            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
