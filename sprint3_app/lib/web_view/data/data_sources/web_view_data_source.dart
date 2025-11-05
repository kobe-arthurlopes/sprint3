import 'package:sprint3_app/web_view/data/models/web_view_data.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDataSource {
  String? url;

  WebViewDataSource({this.url});

  Future<WebViewData> fetch({Function()? onPageStarted}) async {
    if (url == null) {
      return WebViewData(errorMessage: 'No link available to open.');
    }

    if (url!.isEmpty) {
      return WebViewData(errorMessage: 'The link seems to be empty.');
    }

    Uri? uri;

    try {
      uri = Uri.parse(url!);

      if (!uri.hasScheme) {
        return WebViewData(errorMessage: 'Invalid link. Please check the address.');
      }
    } catch (error) {
      return WebViewData(errorMessage: 'Invalid link: $error');
    }

    try {
      final response = await http.head(uri).timeout(const Duration(seconds: 3));

      switch (response.statusCode) {
        case 400:
          return WebViewData(errorMessage: 'Couldn’t open the page. The link might be incorrect.');
        case 401:
          return WebViewData(errorMessage: 'You need to log in to access this page.');
        case 403:
          return WebViewData(errorMessage: 'Access denied. This page isn’t available for you.');
        case 404:
          return WebViewData(errorMessage: 'Page not found. The link may be outdated.');
        case 500:
          return WebViewData(errorMessage: 'The website is having issues. Try again later.');
        default:
          break;
      }
    } catch (_) {
      return WebViewData(errorMessage: 'Couldn’t open the page. Please check your connection or the link.');
    }

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
  }
}