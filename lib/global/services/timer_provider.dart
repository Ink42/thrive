import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  int _elapsedSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  int get elapsedSeconds => _elapsedSeconds;
  bool get isRunning => _isRunning;

  void startTimer() {
    if (_isRunning) return; 
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      notifyListeners(); 
    });
  }

  void stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _elapsedSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
