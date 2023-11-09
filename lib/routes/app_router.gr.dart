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
    NewContactRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewContactScreen(),
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
/// [NewContactScreen]
class NewContactRoute extends PageRouteInfo<void> {
  const NewContactRoute({List<PageRouteInfo>? children})
      : super(
          NewContactRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewContactRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
