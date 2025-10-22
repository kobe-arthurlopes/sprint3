import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/blog_post.dart';

class Repository {
  final Client contentful = Client(
    BearerTokenHTTPClient('IGj4UOLG5NbhMUw5ozI-fK7XmZ3Ukad6tG-TlS9vNXU'),
    spaceId: 'zd1g1rj11jqo',
    environment: 'master'
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