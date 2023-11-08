import 'package:bizcard/screens/scan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      const ProviderScope(
          child: MyApp(),
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CupertinoApp(
      title: 'Bizcard',
      home: ScanScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}