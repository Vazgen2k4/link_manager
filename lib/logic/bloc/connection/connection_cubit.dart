import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:link_manager/app_logger.dart';

part 'connection_cubit_state.dart';

class ConnectionCubit extends Cubit<ConnectionCubitState> {
  ConnectionCubit() : super(ConnectionCubitState()) {
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivitySubscription = _connectivityStream.listen((results) {
      emit(state.copyWith(
        isConnected: _checkConnectionFromList(results),
      ));
    });
  }

  late Stream<List<ConnectivityResult>> _connectivityStream;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> checkConnection() async {
    final List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    AppLogger.logHint('ConnectionMiddleware: $results');

    emit(
      state.copyWith(
        isConnected: _checkConnectionFromList(results),
      ),
    );
  }

  bool _checkConnectionFromList(List<ConnectivityResult> results) => results.any(
        (r) => ConnectionCubitState.correctConnections.contains(r),
      );

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();

    return super.close();
  }
}
