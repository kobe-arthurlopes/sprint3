import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sprint3_app/firebase_options.dart';

class TokenProvider {
  final String? accessTokenCDA;
  final String? spaceIdCDA;
  final String? accessTokenCMA;
  final String? newsApiKey;

  TokenProvider._(
    this.accessTokenCDA,
    this.spaceIdCDA,
    this.accessTokenCMA,
    this.newsApiKey
  );

  static Future<TokenProvider> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

    return TokenProvider._(
      remoteConfig.getString('CONTENTFUL_CDA_ACCESS_TOKEN'),
      remoteConfig.getString('CONTENTFUL_SPACE_ID'),
      remoteConfig.getString('CONTENTFUL_CMA_ACCESS_TOKEN'),
      remoteConfig.getString('NEWS_API_KEY')
    );
  }
}