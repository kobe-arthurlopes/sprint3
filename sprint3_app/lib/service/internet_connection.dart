import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionChecker {
  static final InternetConnectionChecker _instance = InternetConnectionChecker._internal();
  factory InternetConnectionChecker() => _instance;

  final InternetConnection internetConnection;

  InternetConnectionChecker._internal()
    : internetConnection = InternetConnection();

  Future<bool> hasInternet() async {
    return await internetConnection.hasInternetAccess;
  }
}