import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/common/models/cms/home_cms_model.dart';
import 'package:sprint3_app/common/models/dto/article_dto.dart';
import 'package:sprint3_app/common/models/dto/banner_dto.dart';
import 'package:sprint3_app/common/models/dto/home_dto.dart';
import 'package:sprint3_app/common/models/dto/news_source_dto.dart';
import 'package:sprint3_app/common/service/api/api_exception.dart';
import 'package:sprint3_app/common/service/api/api_service_protocol.dart';
import 'package:sprint3_app/common/service/cms_connection.dart';

class HomeRemoteDataSource {
  final ApiServiceProtocol apiService;
  final CmsConnectionProtocol cmsConnection;

  HomeRemoteDataSource({required this.apiService, required this.cmsConnection});

  Future<HomeData> fetch() async {
    HomeCMSModel.registerChildren();

    try {
      final cmsModel = await cmsConnection.findAll<HomeCMSModel>();
      final homeDto = HomeDTO.fromCMS(cmsModel);
      final newsSources = NewsSourceDTO.getActiveNewsSources(homeDto.carousel.newsSources);
      final banners = BannerDTO.getActiveBanners(homeDto.banners);

      final articleResponse = await apiService.fetchResponse(
        fromJson: ArticleResponse.fromJson,
        properties: {'category': 'general'},
      );

      return HomeData(
        newsSources: newsSources,
        banners: banners,
        articles: articleResponse.articles
      );
    } on ApiException catch (error) {
      return HomeData(errorMessage: error.userMessage);
    } catch (_) {
      return HomeData(errorMessage: 'Failed to load content. Please connect to the internet.');
    }
  }
}
