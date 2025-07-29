
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnectivityController with ChangeNotifier {
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  late StreamSubscription connectivitySubscription;

  CheckInternetConnectivityController() {
    _init();
  }

  void _init() {
    _checkConnection();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((_) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    final result = await InternetConnectionChecker().hasConnection;
    if (result != _hasInternet) {
      _hasInternet = result;
      notifyListeners();
    }
  }

  @override
  void dispose(){
    connectivitySubscription.cancel();
    super.dispose();
  }
}