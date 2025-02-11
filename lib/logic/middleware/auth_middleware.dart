import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/ui/router/app_router.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthMiddleware extends StatelessWidget {
  final Widget child;
  const AuthMiddleware({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        AppLogger.logHint('AuthMiddleware: $state');

        if (state is! AuthLoaded) {
          return;
        }

        if (state.hasAuth) {
          AppRouter.goRoute(context, AppRoutes.home, withRemoveUntil: true);
          return;
        }

        AppRouter.goRoute(context, AppRoutes.auth, withRemoveUntil: true);
      },
      child: child,
    );
  }
}
