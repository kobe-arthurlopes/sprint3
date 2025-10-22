import 'package:contentful/contentful.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sprint3_app/models/blog_post.dart';

class Repository {
  late final String accessToken;
  late final String spaceId;

  Repository._(this.accessToken, this.spaceId);

  static Future<Repository> create() async {
    await dotenv.load(fileName: ".env");
    return Repository._(
      dotenv.env["API_KEY"] ?? "",
      dotenv.env["SPACE_ID"] ?? ""
    );
  }

  Future<List<BlogPost>> findAll() async {
    final Client contentful = Client(
      BearerTokenHTTPClient(accessToken),
      spaceId: spaceId,
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