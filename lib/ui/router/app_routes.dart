import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/pages/auth/auth_page.dart';
import 'package:link_manager/ui/pages/calc/calc_tab.dart';
import 'package:link_manager/ui/pages/home/home_page.dart';
import 'package:link_manager/ui/pages/home/home_tab.dart';
import 'package:link_manager/ui/pages/profile/profile_page.dart';
import 'package:link_manager/ui/pages/profile/profile_tab.dart';
import 'package:link_manager/ui/pages/search/search_page.dart';
import 'package:link_manager/ui/pages/settings/settings_tab.dart';
import 'package:link_manager/ui/pages/start/start_page.dart';

sealed class AppRoutes {
  const AppRoutes._();

  static const String start = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String search = '/search';

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
      AppRoute(page: SettingsTab(), path: settings),
      AppRoute(page: CalcTab(), path: calc),
      AppRoute(page: SearchFolderPage(), path: search),
    ];

    return routesList.toSet().toList();
  }

  static List<AppTab> get homeTabs => [
        AppTab(
          name: 'Home',
          icon: Icons.home,
          route: home,
          child: HomeTab(
            key: const Key('home_tab'),
          ),
          getTitle: (context) => S.of(context).home_page_title,
        ),
        AppTab(
          name: 'Calc',
          icon: Icons.calculate,
          route: calc,
          child: CalcTab(
            key: const Key('calc_tab'),
          ),
          getTitle: (context) => S.of(context).calc_title,
        ),
        AppTab(
          name: 'Profile',
          icon: Icons.person,
          route: profile,
          child: ProfileTab(
            key: const Key('profile_tab'),
          ),
          getTitle: (context) => S.of(context).profile_page_title,
        ),
        AppTab(
          name: 'Settings',
          icon: Icons.settings,
          route: settings,
          child: SettingsTab(
            key: const Key('settings_tab'),
          ),
          getTitle: (context) => S.of(context).settings_title,
        ),
      ];
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

class AppTab extends Equatable {
  final String name;
  final IconData icon;
  final String route;
  final Widget child;
  final String Function(BuildContext) getTitle;

  const AppTab({
    required this.name,
    required this.icon,
    required this.route,
    required this.child,
    required this.getTitle,
  });

  @override
  List<Object> get props => [name, icon, route];
}
