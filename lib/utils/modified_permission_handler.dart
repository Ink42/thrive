import 'package:permission_handler/permission_handler.dart';

class ModifiedPermissionHandler {
  static Future<bool> checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() ==
          PermissionStatus.granted;
    }

    return granted;
  }
}