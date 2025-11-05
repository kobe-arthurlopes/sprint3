import 'package:sprint3_app/web_view/data/models/web_view_data.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDataSource {
  String? url;

  WebViewDataSource({this.url});

  Future<WebViewData> fetch({Function()? onPageStarted}) async {
    if (url == null) {
      return WebViewData(errorMessage: 'URL not provided');
    }

    if (url!.isEmpty) {
      return WebViewData(errorMessage: 'Invalid URL: The URL is empty');
    }

    Uri? uri;

    try {
      uri = Uri.parse(url!);

      if (!uri.hasScheme) {
        return WebViewData(errorMessage: 'Invalid URL: No scheme found');
      }
    } catch (error) {
      return WebViewData(errorMessage: 'Invalid URL: $error');
    }

    bool urlExists;

    try {
      final response = await http.head(uri).timeout(const Duration(seconds: 3));
      urlExists = response.statusCode < 400;
    } catch (_) {
      urlExists = false;
    }

    if (urlExists) {
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              if (onPageStarted != null) {
                onPageStarted();
              }
            }
          )
        )
        ..loadRequest(uri);

      return WebViewData(controller: controller);
    } else {
      return WebViewData(errorMessage: 'Invalid URL: Host not found');
    }
  }
}