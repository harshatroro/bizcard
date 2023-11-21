// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ContactsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactsScreen(),
      );
    },
    NewContactRoute.name: (routeData) {
      final args = routeData.argsAs<NewContactRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewContactScreen(
          key: args.key,
          contact: args.contact,
        ),
      );
    },
    ScanRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScanScreen(),
      );
    },
  };
}

/// generated route for
/// [ContactsScreen]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute({List<PageRouteInfo>? children})
      : super(
          ContactsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewContactScreen]
class NewContactRoute extends PageRouteInfo<NewContactRouteArgs> {
  NewContactRoute({
    Key? key,
    required Contact contact,
    List<PageRouteInfo>? children,
  }) : super(
          NewContactRoute.name,
          args: NewContactRouteArgs(
            key: key,
            contact: contact,
          ),
          initialChildren: children,
        );

  static const String name = 'NewContactRoute';

  static const PageInfo<NewContactRouteArgs> page =
      PageInfo<NewContactRouteArgs>(name);
}

class NewContactRouteArgs {
  const NewContactRouteArgs({
    this.key,
    required this.contact,
  });

  final Key? key;

  final Contact contact;

  @override
  String toString() {
    return 'NewContactRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [ScanScreen]
class ScanRoute extends PageRouteInfo<void> {
  const ScanRoute({List<PageRouteInfo>? children})
      : super(
          ScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScanRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
