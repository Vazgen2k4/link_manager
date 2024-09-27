import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.signal_wifi_connected_no_internet_4_rounded,
              size: 100,
            ),
            SizedBox(height: 16),
            Text('Нет соединения с интернетом'),
          ],
        ),
      ),
    );
  }
}
