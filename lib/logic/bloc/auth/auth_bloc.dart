import 'package:bloc/bloc.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

    final logValue = 'Авторизация ${hasAuth ? 'присутствует' : 'отсутствует'}';
    AppLogger.logInfo(logValue);
    AppUser? user;

    if (hasAuth) {
      AppLogger.logInfo('Загрузка пользователя');
      final id = auth.currentUser?.uid;
      user = await FirebaseApi.getUser(id: id);
    }

    final state = AuthLoaded(hasAuth: hasAuth, currentUser: user);
    emit(state);
  }

  Future<void> _logOut(
    AuthLogOut event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthLoaded) {
      AppLogger.logWarning('Проблема с состоянием');
      return;
    }

    try {
      await googleSignIn.signOut();
      await auth.signOut();
      const newState = AuthLoaded(
        hasAuth: false,
        currentUser: null,
      );

      emit(newState);
    } catch (e, stackTrace) {
      AppLogger.logError('Ошибка выхода: $e', stackTrace: stackTrace);
    }
  }

  Future<void> _authWithGoogle(
    AuthWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    if (this.state is! AuthLoaded) {
      AppLogger.logWarning('Проблема с состоянием');
      return;
    }

    final state = this.state as AuthLoaded;

    
      final googleUser = await googleSignIn.signIn();

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
      final currentUser = await FirebaseApi.getUser(id: id);

      emit(state.copyWith(
        hasAuth: true,
        currentUser: currentUser,
      ));
    
  }
}
