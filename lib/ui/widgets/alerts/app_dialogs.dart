import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/widgets/alerts/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class AppDialogs {
  static String _getLinkValueByType({
    required AppLinkType type,
    required String link,
  }) {
    switch (type) {
      case AppLinkType.phone:
        return 'tel:$link';
      case AppLinkType.email:
        return 'mailto:$link';
      default:
        return link;
    }
  }

  static Future<bool?> getApprovement(
    BuildContext context,
    String message,
  ) async {
    return await showDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Удаление'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Подтвердить'),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> addFolderDialog(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertWidget(
          onSucsess: (name, link, type) async {
            final state = context.read<AuthBloc>().state;
            if (state is! AuthLoaded) {
              return;
            }

            final user = state.curentUser;
            if (user == null) {
              return;
            }

            final folders = user.folders.where((el) => el.name == name);

            if (folders.isNotEmpty) {
              const snackBar = SnackBar(
                content: Text('Такая Директория уже существует'),
                duration: Duration(seconds: 3),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            final id = FirebaseAuth.instance.currentUser?.uid;

            int position = 1;
            if (user.folders.isNotEmpty) {
              position = (user.folders.last.position ?? -1) + 1;
            }

            final newFolder = Folder(
              name: name,
              link: _getLinkValueByType(type: type, link: link),
              position: position,
              appLinks: [],
            );

            user.folders.add(newFolder);
            await FirebaseApi.updateUserById(user: user, id: id);
          },
        );
      },
    );
  }

  static Future<bool?> addLinkToFolderDialog(
    BuildContext context,
    int folderIndex,
  ) async {
    return await showDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertWidget(
          onSucsess: (name, link, type) async {
            final state = context.read<AuthBloc>().state;
            if (state is! AuthLoaded) {
              return;
            }

            final user = state.curentUser;
            if (user == null) {
              return;
            }

            final folder = user.folders[folderIndex];

            final linkList = folder.appLinks.where((el) => el.text == name);

            if (linkList.isNotEmpty) {
              const snackBar = SnackBar(
                content: Text('Такая ссылка уже существует'),
                duration: Duration(seconds: 3),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            final id = FirebaseAuth.instance.currentUser?.uid;

            final newLink = AppLink(
              type: type,
              text: name,
              value: _getLinkValueByType(type: type, link: link),
            );

            folder.appLinks.add(newLink);
            await FirebaseApi.updateUserById(user: user, id: id);
          },
        );
      },
    );
  }
}
