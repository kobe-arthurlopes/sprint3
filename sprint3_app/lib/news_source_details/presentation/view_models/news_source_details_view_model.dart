import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/news_source_details/data/models/news_source_details_data.dart';
import 'package:sprint3_app/news_source_details/data/repositories/news_source_details_repository.dart';

class NewsSourceDetailsViewModel {
  final NewsSourceDetailsRepository repository;
  final ValueNotifier<NewsSourceDetailsData> data = ValueNotifier(
    NewsSourceDetailsData(),
  );

  NewsSourceDetailsViewModel({required this.repository});

  Future<void> fetch() async {
    data.value = NewsSourceDetailsData();
    final newsSourceDetailsData = await repository.fetchData();
    data.value = newsSourceDetailsData;
  }

  void setSourceId(String? id) {
    repository.local.sourceId = id;
    repository.remote.sourceId = id;
  }
}
