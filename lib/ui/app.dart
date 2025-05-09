import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/logic/bloc/connection/connection_cubit.dart';
import 'package:link_manager/logic/bloc/cubit/version_cubit.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VersionCubit>(
          create: (_) => VersionCubit(),
        ),
        BlocProvider<ConnectionCubit>(
          create: (_) => ConnectionCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) {
            final bloc = AuthBloc();
            bloc.add(const AuthLoading());
            return bloc;
          },
        ),
        BlocProvider<SettingsBloc>(
          lazy: false,
          create: (_) {
            final bloc = SettingsBloc();
            bloc.add(const SettingsEventLoad());
            return bloc;
          },
        ),
        BlocProvider<CalcBloc>(
          lazy: false,
          create: (_) {
            final bloc = CalcBloc();
            bloc.add(const CalcInit());
            return bloc;
          },
        ),
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
    final settings = context.watch<SettingsBloc>();
    String lang = 'en';

    if (settings.state is SettingsLoaded) {
      final state = settings.state as SettingsLoaded;
      lang = state.lang;
    }

    final locale = Locale(lang);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: AppRouter.initRoute,
      onGenerateRoute: AppRouter.generate,
    );
  }
}
