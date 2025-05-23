part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoaded extends AuthState {
  final bool hasAuth;
  final AppUser? currentUser;

  const AuthLoaded({
    required this.hasAuth,
    required this.currentUser,
  });

  @override
  List<Object?> get props => [hasAuth, currentUser];

  AuthLoaded copyWith({
    bool? hasAuth,
    AppUser? currentUser,
  }) {
    return AuthLoaded(
      hasAuth: hasAuth ?? this.hasAuth,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
