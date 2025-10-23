import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/blog_post.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;

  CmsConnection({required this.accessToken, required this.spaceId});

  Future<List<BlogPost>> findAll() async {
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
      final collection = await contentful.getEntries<BlogPost>({
        'content_type': 'blogPost',
        'include': '10',
      }, BlogPost.fromJson);

      return collection.items;
    } catch (e) {
      print(e);

      return [];
    }
  }
}