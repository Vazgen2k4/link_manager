import 'package:flutter/foundation.dart';
import 'package:link_manager/logic/models/folder/folder.dart';

class AppUser {
  final String? name;
  final String? email;
  final AppUserRole role;
  final List<Folder> folders;

  AppUser({
    this.name,
    this.email,
    List<Folder>? folders,
    this.role = AppUserRole.user,
  }) : folders = folders ?? [];

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final String? name = json['name'];
    final String? email = json['email'];
    final folders = <Folder>[];

    if (json['folders'] != null) {
      json['folders'].forEach((v) {
        folders.add(Folder.fromJson(v));
      });
    }

    AppUserRole role = AppUserRole.user;

    try {
      role = AppUserRole.values.byName(json['role']);
    } catch (e) {
      if (kDebugMode) {
        print("Нет роли у пользователя или неверный тип роли: $name");
        print("Установка роли простого пользователя");
      }

      role = AppUserRole.user;
    }

    return AppUser(
      name: name,
      email: email,
      folders: folders,
      role: role,
    );
  }

  AppUser copyWith({
    String? name,
    String? email,
    List<Folder>? folders,
    AppUserRole? role,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      folders: folders ?? this.folders,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['folders'] = folders.map((v) => v.toJson()).toList();
    data['role'] = role.toString().split('.').last;

    return data;
  }
}

enum AppUserRole {
  user,
  admin,
  banned,
}
