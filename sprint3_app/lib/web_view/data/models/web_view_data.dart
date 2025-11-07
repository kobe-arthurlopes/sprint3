import 'package:webview_flutter/webview_flutter.dart';

class WebViewData {
  WebViewController? controller;
  String? errorMessage;
  bool isLoading;

  WebViewData({
    this.errorMessage, 
    this.isLoading = true,
    this.controller
  });

  WebViewData copyWith({
    WebViewController? controller,
    String? errorMessage,
    bool? isLoading
  }) {
    return WebViewData(
      controller: controller ?? this.controller,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading
    );
  }
}