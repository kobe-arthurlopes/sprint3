import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sprint3_app/models/cms/cms_model.dart';

abstract class CmsConnectionProtocol {
  Future<T> findAll<T extends CmsModelProtocol>();
  void initClient({
    required String? accessToken,
    required String? spaceId,
    String environment = 'master'
  });
}

class CmsConnection implements CmsConnectionProtocol {
  late final GraphQLClient _client;

  @override
  void initClient({
    required String? accessToken, 
    required String? spaceId,
    String environment = 'master'
  }) {
    if (accessToken == null || spaceId == null) {
      throw Exception('Missing accessToken or spaceId');
    }

    final String endpoint =
        'https://graphql.contentful.com/content/v1/spaces/$spaceId/environments/$environment';

    final HttpLink httpLink = HttpLink(
      endpoint,
      defaultHeaders: {'Authorization': 'Bearer $accessToken'},
    );

    _client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  @override
  Future<T> findAll<T extends CmsModelProtocol>() async {
    final String contentType = CmsModelProtocol.contentTypeOf<T>();
    final String fieldsQuery = CmsModelProtocol.fieldsQueryOf<T>();

    final String query = '''
      query {
        ${contentType}Collection(limit: 1) {
          items {
            $fieldsQuery
          }
        }
      }
    ''';

    final result = await _client.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final items = result.data?['${contentType}Collection']?['items'] as List?;

    if (items == null || items.isEmpty) {
      throw Exception('No $T content found');
    }

    return CmsModelProtocol.fromJsonOf<T>(items.first);
  }
}