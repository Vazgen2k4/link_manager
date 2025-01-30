import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/ui/pages/internet/no_internet_page.dart';

class ConnectionMiddleware extends StatelessWidget {
  static const List<ConnectivityResult> _correctConnections = [
    ConnectivityResult.mobile,
    ConnectivityResult.wifi,
    ConnectivityResult.ethernet,
  ];

  final Widget child;
  final bool isAuthPage;

  const ConnectionMiddleware({
    super.key,
    required this.child,
    this.isAuthPage = false,
  });

  Future<bool> haveConnection() async {
    final List<ConnectivityResult> results =
        await Connectivity().checkConnectivity();
    AppLogger.logHint('ConnectionMiddleware: $results');

    return results.any((r) => _correctConnections.contains(r));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: haveConnection(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          AppLogger.logHint('ConnectionMiddleware: ${snapshot.error}');
          return const NoInternetPage();
        }

        if (snapshot.data ?? false) {
          return child;
        }

        return const NoInternetPage();
      },
    );
  }
}
