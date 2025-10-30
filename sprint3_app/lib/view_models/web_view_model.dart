import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WebViewData {
  String? errorMessage;
  bool isLoading;

  WebViewData({
    required this.errorMessage, 
    required this.isLoading
  });

  WebViewData copyWith({
    String? errorMessage,
    bool? isLoading
  }) {
    return WebViewData(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading
    );
  }
}

class WebViewModel {
  ValueNotifier<WebViewData> webViewData = ValueNotifier(
    WebViewData(
      errorMessage: null,
      isLoading: true
    )
  );

  Future<Uri?> getUri(String? url) async {
    if (url == null) {
      webViewData.value = webViewData.value.copyWith(errorMessage: 'URL not provided');
      return null;
    }

    if (url.isEmpty) {
      webViewData.value = webViewData.value.copyWith(errorMessage: 'Invalid URL: The URL is empty');
      return null;
    }

    Uri? uri;

    try {
      uri = Uri.parse(url);

      if (!uri.hasScheme) {
        webViewData.value = webViewData.value.copyWith(errorMessage: 'Invalid URL: No scheme found');
        return null;
      }
    } catch (error) {
      webViewData.value = webViewData.value.copyWith(errorMessage: 'Invalid URL: $error');
      return null;
    }

    bool urlExists;

    try {
      final response = await http.head(uri).timeout(const Duration(seconds: 3));
      urlExists = response.statusCode < 400;
    } catch (_) {
      urlExists = false;
    }

    if (urlExists) {
      return uri;
    } else {
      webViewData.value = webViewData.value.copyWith(errorMessage: 'Invalid URL: Host not found');
      return null;
    }
  }

  void updateErrorMessage(Object error) {
    webViewData.value = webViewData.value.copyWith(errorMessage: 'Error loading Webpage: $error');
  }

  void toggleIsLoading() {
    final isLoading = webViewData.value.isLoading;
    webViewData.value = webViewData.value.copyWith(isLoading: !isLoading);
  }
}