import 'package:auto_route/auto_route.dart';
import 'package:bizcard/providers/camera_provider.dart';
import 'package:bizcard/routes/app_router.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
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
      navigationBar:  CupertinoNavigationBar(
        middle: const Text('Scan Card'),
        trailing:CupertinoButton(
          padding: const EdgeInsets.all(8.0),
          onPressed: () {
            context.router.push(const ContactsRoute());
          },
          child: const Icon(
            CupertinoIcons.rectangle_on_rectangle_angled,
            semanticLabel: 'Contacts',
          ),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<CameraController>(
          future: cameraController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  CameraPreview(snapshot.data!),
                  Positioned(
                    bottom: 50,
                    left: MediaQuery.of(context).size.width / 2 - 25,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(50),
                      color: CupertinoColors.activeBlue,
                      padding: const EdgeInsets.all(16),
                      onPressed: () {
                        debugPrint('Scan button pressed');
                        //  TODO: Add scan functionality
                        context.router.push(const NewContactRoute());
                      },
                      child: const Icon(
                        CupertinoIcons.camera,
                        semanticLabel: 'Scan',
                      ),
                    ),
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
