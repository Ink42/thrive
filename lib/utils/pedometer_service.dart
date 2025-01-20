import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:thrive/utils/modified_permission_handler.dart';

class PedestrianProvider extends ChangeNotifier {
  String _status = '?';
  String _steps = '0';
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  bool _register_steps = false;

  String get status => _status;
  String get steps => _steps;
  bool get register_steps => _register_steps;

  void register(bool value) {
    _register_steps = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    if (_register_steps) return; 

    bool granted =
        await ModifiedPermissionHandler.checkActivityRecognitionPermission();
    if (!granted) {
      _status = 'Permission not granted';
      notifyListeners();
      return;
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    (await _pedestrianStatusStream.listen(_onPedestrianStatusChanged))
        .onError(_onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
    _register_steps = true;
    notifyListeners(); 
  }

  void _onStepCount(StepCount event) {
    if (!_register_steps) return;
    _steps = event.steps.toString();
    notifyListeners();
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    if (!_register_steps) return;
    _status = event.status;
    notifyListeners();
  }

  void _onStepCountError(dynamic error) {
    if (!_register_steps) return;
    _steps = 'Step Count not available: $error';
    notifyListeners();
  }

  void _onPedestrianStatusError(dynamic error) {
    if (!_register_steps) return;
    _status = 'Pedestrian Status not available: $error';
    notifyListeners();
  }

  void clearSteps() {
    _steps = '0';
    notifyListeners();
  }
}
