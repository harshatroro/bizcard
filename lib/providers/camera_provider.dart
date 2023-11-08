import 'package:bizcard/providers/camera_permission_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraControllerProvider = FutureProvider<CameraController>((ref) async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final cameraController = CameraController(
    firstCamera,
    ResolutionPreset.max,
  );
  final cameraPermission = await ref.read(cameraPermissionProvider.future);
  if(cameraPermission) {
    await cameraController.initialize();
    return cameraController;
  } else {
    openAppSettings();
    return cameraController;
  }
});