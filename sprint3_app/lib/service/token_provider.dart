import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenProvider {
  late final String? contentfulAccessToken;
  late final String? contentfulSpaceId;
  late final String? apiKey;

  TokenProvider._(this.contentfulAccessToken, this.contentfulSpaceId, this.apiKey);

  static Future<TokenProvider> create() async {
    await dotenv.load(fileName: '.env');
    final Map<String, String> env = dotenv.env;

    return TokenProvider._(
      env['CONTENTFUL_ACCESS_TOKEN'], 
      env['CONTENTFUL_SPACE_ID'], 
      env['API_KEY']
    );
  }
}