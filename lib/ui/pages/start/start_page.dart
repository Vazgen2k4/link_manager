import 'package:link_manager/logic/middleware/middleware.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Middleware(
      child: Scaffold(
        body: loadWidget,
      ),
    );
  }
}
