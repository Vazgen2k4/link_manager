import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/bloc/connection/connection_cubit.dart';
import 'package:link_manager/ui/pages/internet/no_internet_page.dart';

class ConnectionMiddleware extends StatelessWidget {
  const ConnectionMiddleware({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCubit, ConnectionCubitState>(
      builder: (context, state) {
        if (!state.isConnected) {
          AppLogger.logHint('ConnectionMiddleware: has no connection');
          return const NoInternetPage();
        }

        return child;
      },
    );
  }
}
