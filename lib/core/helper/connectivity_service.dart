import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectionStatus { wifi, mobile, none }

class ConnectivityService {
  ConnectivityService._() {
    // Listen to each ConnectivityResult
    Connectivity().onConnectivityChanged.listen(_onChange);
  }
  static final instance = ConnectivityService._();

  final _controller = StreamController<ConnectionStatus>.broadcast();
  Stream<ConnectionStatus> get onStatusChange => _controller.stream;

  void _onChange(List<ConnectivityResult> results) {
    ConnectionStatus status;
    // We'll use the first result to determine the status (you might want to handle multiple results differently)
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;

    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        status = ConnectionStatus.wifi;
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        status = ConnectionStatus.mobile;
        break;
      case ConnectivityResult.none:
      default:
        status = ConnectionStatus.none;
    }
    _controller.add(status);
  }

  Future<ConnectionStatus> check() async {
    final results = await Connectivity().checkConnectivity();
    // We'll use the first result to determine the status
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;

    return (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet)
        ? ConnectionStatus.wifi
        : (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.vpn ||
                result == ConnectivityResult.other)
            ? ConnectionStatus.mobile
            : ConnectionStatus.none;
  }

  void dispose() => _controller.close();
}
