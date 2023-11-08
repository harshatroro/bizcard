import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraPermissionProvider = FutureProvider<bool>((ref) async {
  final status = await Permission.camera.status;
  if (status.isGranted) {
    return true;
  } else {
    final result = await Permission.camera.request();
    return result.isGranted;
  }
});