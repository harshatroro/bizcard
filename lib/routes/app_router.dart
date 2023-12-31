import 'package:auto_route/auto_route.dart';
import 'package:bizcard/models/contact.dart';
import 'package:bizcard/screens/contacts_screen.dart';
import 'package:bizcard/screens/new_contact_screen.dart';
import 'package:bizcard/screens/scan_screen.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ScanRoute.page, initial: true),
    AutoRoute(page: NewContactRoute.page),
    AutoRoute(page: ContactsRoute.page),
  ];
}