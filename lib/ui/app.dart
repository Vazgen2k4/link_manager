import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/ui/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(const AuthLoading()),
        )
      ],
      child: const AppContent(),
    );
  }
}


class AppContent extends StatelessWidget {
  const AppContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: AppRouter.initRoute,
      onGenerateRoute: AppRouter.generate,
    );
  }
}
