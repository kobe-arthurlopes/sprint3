import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';

class HomeViewModel {
  final HomeRepository repository;
  final ValueNotifier<HomeData> data = ValueNotifier(HomeData());

  HomeViewModel({required this.repository});

  Future<void> fetch() async {
    data.value = data.value.copyWith(shouldStartImagesTimeout: false);
    final homeData = await repository.fetchData();
    data.value = homeData;
    data.value = data.value.copyWith(shouldStartImagesTimeout: true);
  }

  Future<void> _clearAll({bool includingChildren = false}) async {
    data.value = HomeData();
    await repository.clearAll(includingChildren: includingChildren);
  }

  Future<void> reload() async {
    final hasInternet = await repository.hasInternet();

    if (hasInternet) {
      await _clearAll();
    }

    data.value = data.value.copyWith(isLoading: true, errorMessage: null);
    await fetch();
    data.value = data.value.copyWith(isLoading: false);
  }
}
