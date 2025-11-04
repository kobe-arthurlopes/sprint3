import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dao/dao_protocol.dart';
import 'package:sprint3_app/pages/banner_details_page.dart';
import 'package:sprint3_app/pages/news_source_details_page.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';
import 'package:sprint3_app/widgets/articles_list.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';
import 'package:sprint3_app/widgets/banners_list.dart';
import 'package:sprint3_app/widgets/news_sources_list.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _viewModel.start();
    // await _viewModel.clearAll();
    await _viewModel.fetchObjects();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.data,
      builder: (_, data, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBarWidget(title: 'News'),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 10,
                    right: 10,
                    bottom: 8,
                  ),
                  child: Text(
                    'Top News Sources',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                NewsSourcesList(
                  newsSources: data.newsSources,
                  onTap: (newsSource) async {
                    if (!context.mounted) {
                      return;
                    }

                    if (ModalRoute.of(context)?.isCurrent == false) {
                      return;
                    }

                    final ApiServiceProtocol apiService = _viewModel.apiService;
                    final DaoProtocol articleDo = _viewModel.articleDao;

                    final _ = await Navigator.of(context).pushNamed(
                      NewsSourceDetailsPage.routeId,
                      arguments: [newsSource, apiService, articleDo]
                    );
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 10,
                        right: 10,
                        bottom: 8,
                      ),
                      child: Text(
                        'Classic Headlines',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    BannersList(
                      banners: data.banners,
                      onTap: (banner) {
                        Navigator.of(context).pushNamed(
                          BannerDetailsPage.routeId,
                          arguments: banner,
                        );
                      },
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        'Top Headlines',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ArticlesList(
                        articles: data.articles,
                        isScrollable: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
