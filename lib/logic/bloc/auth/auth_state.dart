part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoaded extends AuthState {
  final bool hasAuth;
  final AppUser? curentUser;

  const AuthLoaded({
    required this.hasAuth,
    required this.curentUser,
  });

  @override
  List<Object?> get props => [hasAuth, curentUser];

  AuthLoaded copyWith({
    bool? hasAuth,
    AppUser? curentUser,
  }) {
    return AuthLoaded(
      hasAuth: hasAuth ?? this.hasAuth,
      curentUser: curentUser ?? this.curentUser,
    );
  }
}
