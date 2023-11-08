import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class NoCameraAvailable extends StatelessWidget {
  const NoCameraAvailable({super.key});

  void allowCameraAccess(context) {
    final request = Permission.camera.request();
    request.then((value) {
      if (value.isGranted) {
        Navigator.pop(context);
      } else if (value.isPermanentlyDenied) {
        openAppSettings();
      } else if (value.isDenied) {
        allowCameraAccess(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'No camera available',
              style: TextStyle(
                color: CupertinoColors.black,
                decoration: TextDecoration.none,
                fontSize: 20,
                fontFamily: 'SF Pro Display',
              ),
            ),
            CupertinoButton(
              child: const Text("Allow Camera Access"),
              onPressed: () {
                allowCameraAccess(context);
              },
            ),
          ],
        ),
      )
    );
  }
}
