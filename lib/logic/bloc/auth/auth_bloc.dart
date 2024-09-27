import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn goolSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoading>(_load);
    on<AuthLogOut>(_logOut);
    on<AuthWithGoogle>(_authWithGoogle);
  }

  Future<void> _load(
    AuthLoading event,
    Emitter<AuthState> emit,
  ) async {
    final hasAuth = FirebaseAuth.instance.currentUser != null;

    log('Авторизация ${hasAuth ? 'Есть БраТишкА)))' : 'Её нетУ Брат'}');

    AppUser? user;

    if (hasAuth) {
      final id = auth.currentUser?.uid;
      user = await FirebaseApi.getUser(id: id);
    }

    final state = AuthLoaded(hasAuth: hasAuth, curentUser: user);
    emit(state);
  }

  Future<void> _logOut(
    AuthLogOut event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthLoaded) {
      log('Проблема со стейтом');
      return;
    }

    try {
      await goolSignIn.signOut();
      await auth.signOut();
      const newState = AuthLoaded(
        hasAuth: false,
        curentUser: null,
      );

      emit(newState);
    } catch (e) {
      log('Error [object] - log Out');
    }
  }

  Future<void> _authWithGoogle(
    AuthWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    if (this.state is! AuthLoaded) {
      log('Проблема со стейтом');
      return;
    }

    final state = this.state as AuthLoaded;

    try {
      final googleUser = await goolSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      final user = auth.currentUser;
      final haveUser = await FirebaseApi.haveUserById(id: user?.uid);

      if (!haveUser) {
        await FirebaseApi.createUserByGoogleAuth(googleUser: user);
      }

      final id = auth.currentUser?.uid;
      final curentUser = await FirebaseApi.getUser(id: id);

      emit(state.copyWith(
        hasAuth: true,
        curentUser: curentUser,
      ));
    } catch (e) {
      log(e.toString());
    }
  }
}
