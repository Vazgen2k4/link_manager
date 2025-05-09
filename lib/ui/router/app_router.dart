import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/logic.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:link_manager/ui/router/error_404_page/error_404_page.dart';

class AppRouter {
  static const _pageDuration = Duration(milliseconds: 400);
  static String get initRoute => AppRoutes.init;

  static Route generate(RouteSettings settings) {
    final routeName = settings.name?.trim();
    if (routeName == null) return _errorRoute404;
    final allAppRoutes = AppRoutes.routes;

    for (var appRoute in allAppRoutes) {
      if (routeName != appRoute.path) continue;

      AppLogger.logInfo('AppRouter: $routeName');

      final newRoute = _getRouteTemplate(
        child: appRoute.page,
        settings: settings,
      );

      return newRoute;
    }

    return _errorRoute404;
  }

  static Route _getRouteTemplate({
    required Widget child,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: _pageDuration,
      reverseTransitionDuration: _pageDuration,
      pageBuilder: (_, __, ___) {
        return Middleware(
          child: child,
        );
      },
    );
  }

  static final Route _errorRoute404 = MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.noFound),
    builder: (_) => const Error404Page(),
  );

  static Future<T?> goRoute<T extends Object?>(
    BuildContext context,
    String route, {
    bool withRemoveUntil = false,
  }) async {
    if (withRemoveUntil) {
      return await Navigator.of(context).pushNamedAndRemoveUntil(
        route,
        (route) => false,
      );
    }

    return await Navigator.of(context).pushNamed(route);
  }

  static bool isAuthPage(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == null) return false;

    return AppRoutes.auth == routeName;
  }
}
