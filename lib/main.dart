import 'package:bizcard/routes/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ProviderScope(
          child: MyApp(),
      ),
  );
}

class MyApp extends ConsumerWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp.router(
      routerConfig: _appRouter.config(),
      title: 'BizCard',
      debugShowCheckedModeBanner: false,
    );
  }
}