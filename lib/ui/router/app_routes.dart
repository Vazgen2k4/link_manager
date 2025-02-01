import 'package:link_manager/ui/pages/auth/auth_page.dart';
import 'package:link_manager/ui/pages/calc/calc_page.dart';
import 'package:link_manager/ui/pages/home/home_page.dart';
import 'package:link_manager/ui/pages/profile/profile_page.dart';
import 'package:link_manager/ui/pages/settings/settings.dart';
import 'package:link_manager/ui/pages/start/start_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

sealed class AppRoutes {
  const AppRoutes._();

  static const String start = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String calc = '/calc';
  static const String settings = '/settings';
  static const String init = start;
  static const String noFound = '/404';

  static List<AppRoute> get routes {
    const routesList = <AppRoute>[
      AppRoute(page: HomePage(), path: home),
      AppRoute(page: AuthPage(), path: auth),
      AppRoute(page: ProfilePage(), path: profile),
      AppRoute(page: StartPage(), path: start),
      AppRoute(page: SettingsPage(), path: settings),
      AppRoute(page: CalcPage(), path: calc),
    ];

    return routesList.toSet().toList();
  }
}

class AppRoute extends Equatable {
  final Widget page;
  final String path;
  const AppRoute({
    required this.page,
    required this.path,
  });

  @override
  List<Object> get props => [path, page];
}
