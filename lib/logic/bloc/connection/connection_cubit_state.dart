part of 'connection_cubit.dart';

final class ConnectionCubitState extends Equatable {
  const ConnectionCubitState({
    this.isConnected = false,
  });
  

  static const List<ConnectivityResult> correctConnections = [
    ConnectivityResult.mobile,
    ConnectivityResult.wifi,
    ConnectivityResult.ethernet,
  ];
  
  final bool isConnected;
  
  ConnectionCubitState copyWith({
    bool? isConnected,
  }) {
    return ConnectionCubitState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
  
  @override
  List<Object> get props => [
    isConnected,
  ];
}
