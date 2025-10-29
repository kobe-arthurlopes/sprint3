import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';

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

  Future<HomeCMSModel> findAll() async {
    const String query = r'''
      query {
        homeCollection(limit: 1) {
          items {
            title
            carousel {
              ... on CarouselNewsSources {
                name
                newsSourcesCollection {
                  items {
                    ... on NewsSource {
                      name
                      sourceId
                      logo {
                        url
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    ''';

    final result = await _client.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final items = result.data?['homeCollection']?['items'] as List?;

    if (items == null || items.isEmpty) {
      throw Exception('No home content found');
    }

    return HomeCMSModel.fromJson(items.first);
  }
}