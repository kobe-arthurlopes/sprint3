import 'package:flutter/material.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  static const routeId = '/webview';

  final String? url;

  const WebviewPage({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebviewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBarWidget(
        title: 'Webview',
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
