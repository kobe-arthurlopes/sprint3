import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/news_source.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;

  CmsConnection({required this.accessToken, required this.spaceId});

  Future<List<NewsSource>> findAll() async {
    if (accessToken == null) {
      return [];
    }

    if (spaceId == null) {
      return [];
    }

    final Client contentful = Client(
      BearerTokenHTTPClient(accessToken!),
      spaceId: spaceId!,
      environment: 'master'
    );

    try {
      final collection = await contentful.getEntries<NewsSource>({
        'content_type': NewsSource.contentType,
        'include': '10',
      }, NewsSource.fromJson);

      return collection.items;
    } catch (e) {
      print(e);

      return [];
    }
  }
}