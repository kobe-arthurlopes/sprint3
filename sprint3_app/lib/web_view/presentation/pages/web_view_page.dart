import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/web_view/presentation/view_models/web_view_model.dart';
import 'package:sprint3_app/components/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static const routeId = '/webView';

  final String? url;

  const WebViewPage({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<WebViewModel>();
    _initialize();
  }

  Future<void> _initialize() async {
    _viewModel.setUrl(widget.url);
    await _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _viewModel.data, 
      builder: (_, data, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBarWidget(title: 'Web View'),
          body: data.errorMessage != null
            ? _buildErrorView(data.errorMessage!)
            : data.controller == null || data.isLoading
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: data.controller!)
        );
      }
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline, 
              color: AppColors.appBarBackground, 
              size: 60
            ),

            const SizedBox(height: 16),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
