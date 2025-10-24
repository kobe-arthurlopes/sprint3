import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/carousel_model.dart';
import 'package:sprint3_app/models/home_model.dart';
import 'package:sprint3_app/models/news_source_model.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;

  CmsConnection({required this.accessToken, required this.spaceId});

  Future<void> findAll() async {
    if (accessToken == null) {
      return;
    }

    if (spaceId == null) {
      return;
    }

    final Client contentful = Client(
      BearerTokenHTTPClient(accessToken!),
      spaceId: spaceId!,
      environment: 'master'
    );

    try {
      // final collection = await contentful.getEntries<HomeModel>({
      //   'content_type': HomeModel.contentType,
      // }, HomeModel.fromJson);

      // print(collection.items);


      final collection = await contentful.getEntries<CarouselModel>({
        'content_type': CarouselModel.contentType,
      }, CarouselModel.fromJson);

      final List<List<NewsSourceModel>?> listNewsSources = collection.items.map((element) => element.fields?.newsSources).toList();

      final List<NewsSourceModel> allNewsSources = listNewsSources
          .where((list) => list != null)
          .expand((list) => list!)
          .toList();

      final List<String?> names = allNewsSources.map((element) => element.fields?.name).toList();

      print(names);
    } catch (e) {
      print(e);
    }
  }
}