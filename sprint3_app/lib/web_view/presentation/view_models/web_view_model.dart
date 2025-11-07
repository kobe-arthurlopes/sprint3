import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/web_view/data/models/web_view_data.dart';
import 'package:sprint3_app/web_view/data/repositories/web_view_repository.dart';

class WebViewModel {
  final WebViewRepository repository;
  final ValueNotifier<WebViewData> data = ValueNotifier(WebViewData());

  WebViewModel({required this.repository});

  Future<void> fetch() async {
    data.value = WebViewData();

    data.value = await repository.fetchData(
      onPageStarted: () {
        data.value = data.value.copyWith(isLoading: false);
      }
    );
  }

  void setUrl(String? url) {
    repository.dataSource.url = url;
  }
}