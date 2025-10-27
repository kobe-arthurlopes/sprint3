import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/carousel_model.dart';
import 'package:sprint3_app/models/home_model.dart';
import 'package:sprint3_app/models/news_source_model.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;

  CmsConnection({required this.accessToken, required this.spaceId});

  Future<List<NewsSourceModel>?> findAll() async {
    if (accessToken == null) {
      return null;
    }

    if (spaceId == null) {
      return null;
    }

    final Client contentful = Client(
      BearerTokenHTTPClient(accessToken!),
      spaceId: spaceId!,
      environment: 'master'
    );

    try {
      final homeModelCollection = await contentful.getEntries<HomeModel>({
        'content_type': HomeModel.contentType,
        'include': '10',
      }, HomeModel.fromJson);

      final home = homeModelCollection.items.first;
      final CarouselModel? carousel = home.fields?.carousel;
      final List<NewsSourceModel>? newsSources = carousel?.fields?.newsSources;

      return newsSources;
    } catch (e) {
      print(e);
    }
  }
}