import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../features/bookmark/presentation/screens/bookmark_album_page.dart';
import '../../features/bookmark/presentation/screens/bookmark_detail_page.dart';
import '../../features/home/presentation/screens/home_page.dart';
import '../../features/splash/presentation/screens/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  /// Central list of routes used by the `auto_route` generator.
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: BookmarkAlbumRoute.page),
    AutoRoute(page: BookmarkDetailRoute.page),
  ];
}

