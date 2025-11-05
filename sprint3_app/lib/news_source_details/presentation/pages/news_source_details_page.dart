import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/news_source_details/presentation/view_models/news_source_details_view_model.dart';
import 'package:sprint3_app/components/articles_list.dart';
import 'package:sprint3_app/components/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatefulWidget {
  static const routeId = '/news_source_details';

  final NewsSourceDTO newsSource;

  const NewsSourceDetailsPage({super.key, required this.newsSource});

  @override
  State<StatefulWidget> createState() => _NewsSourceDetailsPageState();
}

class _NewsSourceDetailsPageState extends State<NewsSourceDetailsPage> {
  late final NewsSourceDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<NewsSourceDetailsViewModel>();
    _initialize();
  }

  Future<void> _initialize() async {
    _viewModel.setSourceId(widget.newsSource.sourceId);
    await _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<NewsSourceDetailsData>(
      valueListenable: _viewModel.data,
      builder: (_, data, _) {
        final newsSource = widget.newsSource;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBarWidget(title: newsSource.name),
          body: data.errorMessage != null
              ? _buildErrorView(data.errorMessage!)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ArticlesList(articles: data.articles),
                ),
        );
      },
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
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
