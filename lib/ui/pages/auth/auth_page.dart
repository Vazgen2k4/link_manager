import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/middleware/middleware.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/widgets/buttons/cooldown_button.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Middleware(
      child: Scaffold(
        body: LimitContainer(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Section(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  title: 'Выполните вход',
                  child: Hero(
                    tag: AppHeroTags.button,
                    child: CooldownButton.text(
                      text: 'Log in with Google',
                      onClick: () async {
                        final authBloc = context.read<AuthBloc>();
                        const authEvent = AuthWithGoogle();
                        authBloc.add(authEvent);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
