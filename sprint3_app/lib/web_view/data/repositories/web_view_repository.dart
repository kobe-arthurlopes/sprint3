import 'package:sprint3_app/web_view/data/data_sources/web_view_data_source.dart';
import 'package:sprint3_app/web_view/data/models/web_view_data.dart';

class WebViewRepository {
  final WebViewDataSource dataSource;

  WebViewRepository({required this.dataSource});

  Future<WebViewData> fetchData({Function()? onPageStarted}) async {
    return await dataSource.fetch(onPageStarted: onPageStarted);
  }
}