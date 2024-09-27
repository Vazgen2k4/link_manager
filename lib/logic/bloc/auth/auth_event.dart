part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthEvent {
  const AuthLoading();
  @override
  List<Object> get props => [];
}


class AuthLogOut extends AuthEvent {
  const AuthLogOut();
  @override
  List<Object> get props => [];
}

class AuthWithGoogle extends AuthEvent {
  const AuthWithGoogle();
  @override
  List<Object> get props => [];
}
