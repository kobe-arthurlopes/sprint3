import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/components/error_widget.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/home/presentation/pages/banner_details_page.dart';
import 'package:sprint3_app/news_source_details/presentation/pages/news_source_details_page.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/home/presentation/view_models/home_view_model.dart';
import 'package:sprint3_app/components/articles_list.dart';
import 'package:sprint3_app/components/app_bar_widget.dart';
import 'package:sprint3_app/home/presentation/components/banners_list.dart';
import 'package:sprint3_app/home/presentation/components/news_sources_list.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<HomeViewModel>();
    _initialize();
  }

  Future<void> _initialize() async {
    await _viewModel.fetch();
  }

  Future<void> _refresh() async {
    await _viewModel.reload();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.data,
      builder: (_, data, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBarWidget(title: 'News'),
          body: data.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : data.errorMessage != null
                      ? CustomErrorWidget(
                        message: data.errorMessage!,
                        onRetry: _refresh,
                      )
                      : _buildMainView(data)
        );
      },
    );
  }

  Widget _buildMainView(HomeData data) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
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
                  color: AppColors.primary
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
      
                await Navigator.of(context).pushNamed(
                  NewsSourceDetailsPage.routeId,
                  arguments: newsSource
                );
              },
              shouldStartTimeout: data.shouldStartImagesTimeout,
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
                  shouldStartTimeout: data.shouldStartImagesTimeout,
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
                        shouldStartTimeout: data.shouldStartImagesTimeout,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}