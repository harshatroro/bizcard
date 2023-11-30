import 'package:auto_route/auto_route.dart';
import 'package:bizcard/models/contact.dart';
import 'package:bizcard/providers/camera_controller_provider.dart';
import 'package:bizcard/providers/contact_provider.dart';
import 'package:bizcard/providers/repository_provider.dart';
import 'package:bizcard/routes/app_router.dart';
import 'package:bizcard/widgets/alert_dialog.dart';
import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  CameraController? _cameraController;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final cameraController = ref.watch(cameraControllerProvider.future);
    return CupertinoPageScaffold(
      navigationBar:  CupertinoNavigationBar(
        middle: const Text('Scan Card'),
        trailing:CupertinoButton(
          padding: const EdgeInsets.all(8.0),
          onPressed: loading
            ? null
            : () {
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
              _cameraController ??= snapshot.data;
              return Stack(
                children: [
                  CameraPreview(_cameraController!),
                  Positioned(
                    bottom: 50,
                    left: MediaQuery.of(context).size.width / 2 - 25,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(50),
                      color: CupertinoColors.activeBlue,
                      padding: const EdgeInsets.all(16),
                      onPressed: loading
                        ? null
                        : () {
                          final connectivityResult = Connectivity().checkConnectivity();
                          connectivityResult.then((value) {
                            if(value == ConnectivityResult.wifi || value == ConnectivityResult.mobile) {
                              setState(() {
                                loading = true;
                              });
                              final repository = ref.read(repositoryProvider.future);
                              repository.then((value) async {
                                XFile image = await _cameraController!.takePicture();
                                await _cameraController!.pausePreview();
                                final string = await value.readTextFromImage(image.path);
                                debugPrint("In ScanScreen: $string");
                                Contact contact = Contact.empty();
                                contact.assignValuesUsingString(string);
                                contact.format();
                                ref.read(contactProvider.notifier).state = contact;
                                _cameraController!.resumePreview();
                                setState(() {
                                  loading = false;
                                });
                                // ignore: use_build_context_synchronously
                                await context.router.push(NewContactRoute(contact: contact, back: () {
                                  context.router.pop();
                                }));
                              });
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: "No Internet Connection",
                                  content: "Please connect to the internet to scan the card",
                                  actionText: "OK",
                                ),
                              );
                              setState(() {
                                loading = false;
                              });
                            }
                          });
                      },
                      child: const Icon(
                        CupertinoIcons.camera,
                        semanticLabel: 'Scan',
                      ),
                    ),
                  ),
                  loading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : const SizedBox.shrink(),
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
