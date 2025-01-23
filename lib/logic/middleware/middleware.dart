import 'package:link_manager/logic/middleware/auth_middleware.dart';
import 'package:link_manager/logic/middleware/connection_middleware.dart';
import 'package:flutter/material.dart';

class Middleware extends StatelessWidget {
  final Widget child;
  const Middleware({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectionMiddleware(
      child: AuthMiddleware(
        child: child,
      ),
    );
  }
}
