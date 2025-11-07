import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint3_app/components/custom_progress_indicator.dart';
import 'package:sprint3_app/components/error_widget.dart';
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
    await _viewModel.fetch();
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
            ? CustomErrorWidget(
              message: data.errorMessage!,
              onRetry: () async {
                await _viewModel.fetch();
              },
            )
            : data.controller == null || data.isLoading
              ? Center(child: CustomProgressIndicator())
              : WebViewWidget(controller: data.controller!)
        );
      }
    );
  }
}
