import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';

class HomeViewModel {
  final HomeRepository repository;
  final ValueNotifier<HomeData> data = ValueNotifier(HomeData());

  HomeViewModel({required this.repository});

  Future<void> fetch() async {
    final homeData = await repository.fetchData();
    data.value = homeData;
  }

  Future<void> clearAll() async {
    data.value = HomeData();
    await repository.clearAll();
  }

  Future<void> reload() async {
    data.value = data.value.copyWith(isLoading: true, errorMessage: null);
    await fetch();
    data.value = data.value.copyWith(isLoading: false);
  }
}