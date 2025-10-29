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
  WebViewController? _controller;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebview();
  }

  void _initializeWebview() {
    final url = widget.url;

    if (url == null || url.isEmpty) {
      setState(() => _errorMessage = 'URL not provided');
      return;
    }

    Uri? uri;

    try {
      uri = Uri.parse(url);

      if (!uri.hasScheme) {
        setState(() => _errorMessage = 'Invalid URL');
        return;
      }
    } catch (e) {
      setState(() => _errorMessage = 'Invalid URL');
      return;
    }

    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) { 
              setState(() => _isLoading = false);
            },
          )
        )
        ..loadRequest(uri);
    } catch (e) {
      setState(() => _errorMessage = 'Error loading Webpage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEDEF),
      appBar: AppBarWidget(
        title: 'Webview',
      ),
      body: _errorMessage != null
        ? _buildErrorView(_errorMessage!)
        : _controller == null || _isLoading
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller!)
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFD32F2F), size: 60),

            const SizedBox(height: 16),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333)
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
