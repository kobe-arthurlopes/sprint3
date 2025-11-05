import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';
import 'package:sprint3_app/models/dto/article_dto_model.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/models/dto/home_dto_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';
import 'package:sprint3_app/service/api_service.dart';
import 'package:sprint3_app/service/cms_connection.dart';

class HomeRemoteDataSource {
  final ApiServiceProtocol apiService;
  final CmsConnectionProtocol cmsConnection;

  HomeRemoteDataSource({required this.apiService, required this.cmsConnection});

  Future<HomeData> fetch() async {
    HomeCMSModel.registerChildren();
    final cmsModel = await cmsConnection.findAll<HomeCMSModel>();
    final homeDto = HomeDTOModel.fromCMS(cmsModel);

    final newsSources = NewsSourceDTOModel.getActiveNewsSources(
      homeDto.carousel.newsSources,
    );

    final banners = BannerDTOModel.getActiveBanners(homeDto.banners);

    final articleResponse = await apiService.fetchResponse(
      fromJson: ArticleResponse.fromJson,
      properties: {'category': 'general'},
    );

    return HomeData(
      newsSources: newsSources,
      banners: banners,
      articles: articleResponse.articles,
    );
  }
}
