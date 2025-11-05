import 'package:flutter/cupertino.dart';
import 'package:sprint3_app/home/data/models/home_data.dart';
import 'package:sprint3_app/home/data/repositories/home_repository.dart';

class HomeViewModel {
  final HomeRepository repository;
  final ValueNotifier<HomeData> data = ValueNotifier(HomeData());

  HomeViewModel({required this.repository});

  Future<void> start() async {
    final homeData = await repository.fetchData();
    data.value = homeData;
  }

  Future<void> clearAll() async {
    await repository.clearAll();
    data.value = HomeData();
  }
}