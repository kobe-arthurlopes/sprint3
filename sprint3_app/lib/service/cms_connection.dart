import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sprint3_app/models/cms/cms_model.dart';

class CmsConnection {
  final String? accessToken;
  final String? spaceId;
  final String environment;

  late final GraphQLClient _client;

  CmsConnection({
    required this.accessToken,
    required this.spaceId,
    this.environment = 'master',
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

  Future<T> findAll<T extends CmsModel>() async {
    final String contentType = CmsModel.contentTypeOf<T>();
    final String fieldsQuery = CmsModel.fieldsQueryOf<T>();

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

    return CmsModel.fromJsonOf<T>(items.first);
  }
}