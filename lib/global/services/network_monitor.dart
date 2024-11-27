
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkMonitor extends ChangeNotifier{
  bool _isConnectedToInternet = false;
  StreamSubscription? _streamSubscription;

  bool get isConnectedToInternet => _isConnectedToInternet;

check() {
  _streamSubscription = InternetConnection().onStatusChange.listen((event) {
    switch (event) {
      case InternetStatus.connected:
        _isConnectedToInternet = true;
        break;
      case InternetStatus.disconnected:
        _isConnectedToInternet = false;
        break;
      default:
        _isConnectedToInternet = false;
    }
    notifyListeners(); 
  });
}


  @override
    void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}