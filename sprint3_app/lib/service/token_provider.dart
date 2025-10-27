import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sprint3_app/firebase_options.dart';

class TokenProvider {
  final String? contentfulAccessToken;
  final String? contentfulSpaceId;
  final String? apiKey;

  TokenProvider._(this.contentfulAccessToken, this.contentfulSpaceId, this.apiKey);

  static Future<TokenProvider> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

    return TokenProvider._(
      remoteConfig.getString('CONTENTFUL_ACCESS_TOKEN'),
      remoteConfig.getString('CONTENTFUL_SPACE_ID'),
      remoteConfig.getString('API_KEY')
    );
  }
}