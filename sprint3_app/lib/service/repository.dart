import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/blog_post.dart';

class Repository {
  final Client contentful = Client(
    BearerTokenHTTPClient('ACCESS_TOKEN'),
    spaceId: 'SPACE_ID',
    environment: 'ENVIRONMENT'
  );

  Future<List<BlogPost>> findAll() async {
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