import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:link_manager/ui/pages/internet/no_internet_page.dart';
import 'package:flutter/widgets.dart';

class ConnectionMiddleware extends StatelessWidget {
  final Widget child;
  final bool isAuthPage;
  const ConnectionMiddleware({
    super.key,
    required this.child,
    this.isAuthPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final connectionData = snapshot.data ?? [];
        
        if(connectionData.contains(ConnectivityResult.none)) {
          return const NoInternetPage();
        }
        
        return child;
      },
    );
  }
}
