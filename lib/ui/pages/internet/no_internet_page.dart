import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.signal_wifi_connected_no_internet_4_rounded,
              size: 100,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).no_connection,
            ),
          ],
        ),
      ),
    );
  }
}
