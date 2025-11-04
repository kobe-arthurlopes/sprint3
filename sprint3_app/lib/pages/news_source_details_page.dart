import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/view_models/news_source_details_view_model.dart';
import 'package:sprint3_app/widgets/articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class NewsSourceDetailsPage extends StatefulWidget {
  static const routeId = '/news_source_details';

  final NewsSourceDTOModel newsSource;
  final ApiServiceProtocol apiService;
  final DaoProtocol articleDao;

  const NewsSourceDetailsPage({
    super.key,
    required this.newsSource,
    required this.apiService,
    required this.articleDao
  });

  @override
  State<StatefulWidget> createState() => _NewsSourceDetailsPageState();
}

class _NewsSourceDetailsPageState extends State<NewsSourceDetailsPage> {
  late final NewsSourceDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _viewModel = NewsSourceDetailsViewModel(
      apiService: widget.apiService, 
      articleDao: widget.articleDao,
      sourceId: widget.newsSource.sourceId
    );

    await _viewModel.setArticles();
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
      }
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
