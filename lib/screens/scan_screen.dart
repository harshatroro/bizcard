import 'package:bizcard/providers/camera_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    final cameraController = ref.watch(cameraControllerProvider.future);
    return CupertinoPageScaffold(
      child: SafeArea(
        child: FutureBuilder<CameraController>(
          future: cameraController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  CameraPreview(snapshot.data!),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.all(16),
                        onPressed: () {
                          debugPrint('Scan button pressed');
                        },
                        child: const Text('Scan'),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
