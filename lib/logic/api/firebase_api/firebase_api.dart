import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract final class FirebaseApi {
  static final _instance = FirebaseFirestore.instance;

  static final users = _instance.collection('users');
  static final settings = _instance.collection('settings');
  static final ctuLinksDoc = settings.doc('ctu_links');

  static Future<bool> setUserById({
    AppUser? user,
    String? id,
  }) async {
    if (user == null || id == null) {
      return false;
    }

    await FirebaseApi.users.doc(id).set(user.toJson());
    return true;
  }

  static Future<bool> updateUserById({
    AppUser? user,
    String? id,
  }) async {
    if (user == null || id == null) {
      return false;
    }

    await FirebaseApi.users.doc(id).set(user.toJson());
    return true;
  }

  static Future<bool> haveUserById({
    String? id,
  }) async {
    if (id == null) {
      return false;
    }

    final doc = await FirebaseApi.users.doc(id).get();
    return doc.exists;
  }

  static Future<bool> createUserByGoogleAuth({
    User? googleUser,
  }) async {
    if (googleUser == null) {
      AppLogger.logWarning('Google user не был передан');
      return false;
    }

    final newUser = AppUser(
      name: googleUser.displayName,
      email: googleUser.email,
      folders: const [],
    );

    return await setUserById(
      user: newUser,
      id: googleUser.uid,
    );
  }

  static Future<AppUser?> getUser({
    String? id,
  }) async {
    if (id == null) {
      AppLogger.logWarning('Id не передан');
      return null;
    }

    final userDoc = await FirebaseApi.users.doc(id).get();
    final userData = userDoc.data();

    if (userData == null) {
      AppLogger.logWarning('Пользователя не существует');
      return null;
    }

    // TODO: это часть миграции
    if (userData['role'] == null) {
      AppLogger.logHint('Мигрирование произошло');

      userData['role'] ??= 'user';
      await updateUserById(
        user: AppUser.fromJson(userData),
        id: id,
      );
    }

    final user = AppUser.fromJson(userData);
    return user;
  }
}
