import 'package:contentful/contentful.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;
  final String environment;

  CmsConnection({
    required this.accessToken, 
    required this.spaceId,
    this.environment = 'master'
  });

  Future<HomeCMSModel> findAll() async {
    if (accessToken == null) {
      throw Exception();
    }

    if (spaceId == null) {
      throw Exception();
    }

    final Client contentful = Client(
      BearerTokenHTTPClient(accessToken!),
      spaceId: spaceId!,
      environment: environment
    );

    try {
      final homeCMSCollection = await contentful.getEntries<HomeCMSModel>({
        'content_type': HomeCMSModel.contentType,
        'include': '10'
      }, HomeCMSModel.fromJson);

      return homeCMSCollection.items.first;
    } catch (e) {
      print(e);
      rethrow;
    }
  } 
}