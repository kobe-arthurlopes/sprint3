import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;

  CmsConnection({required this.accessToken, required this.spaceId});

  Future<List<NewsSourceCMSModel>?> findAll() async {
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
      final homeModelCollection = await contentful.getEntries<HomeCMSModel>({
        'content_type': HomeCMSModel.contentType,
        'include': '10',
      }, HomeCMSModel.fromJson);

      final home = homeModelCollection.items.first;
      final CarouselCMSModel? carousel = home.fields?.carousel;
      final List<NewsSourceCMSModel>? newsSources = carousel?.fields?.newsSources;

      return newsSources;
    } catch (e) {
      print(e);
    }
    return null;
  }
}