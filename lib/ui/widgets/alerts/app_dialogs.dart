import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/alerts/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/ui/widgets/alerts/create_folder_alert.dart';

abstract final class AppDialogs {
  static Future<bool?> getApprovement(
    BuildContext context,
    String message,
  ) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).delete),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> addFolderDialog(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return CreateFolderAlert(
          onSucsess: (name, link) async {
            final state = context.read<AuthBloc>().state;
            if (state is! AuthLoaded) {
              return;
            }

            final user = state.currentUser;
            if (user == null) {
              return;
            }

            final folders = user.folders.where((el) => el.name == name);

            if (folders.isNotEmpty) {
              final snackBar = SnackBar(
                content: AutoSizeText(
                  S.of(context).folder_exists,
                ),
                duration: const Duration(seconds: 3),
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
              link: link,
              position: position,
              appLinks: [],
            );

            user.folders.add(newFolder);

            final snackBar = SnackBar(
              backgroundColor: AppColors.correct,
              content: AutoSizeText(
                S.of(context).folder_create.replaceFirst(r'$', name),
              ),
              duration: const Duration(seconds: 3),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      builder: (context) {
        return AlertWidget(
          onSucsess: (name, link, type) async {
            final state = context.read<AuthBloc>().state;
            if (state is! AuthLoaded) {
              return;
            }

            final user = state.currentUser;
            if (user == null) {
              return;
            }

            final folder = user.folders[folderIndex];

            final linkList = folder.appLinks.where((el) => el.text == name);

            if (linkList.isNotEmpty) {
              final snackBar = SnackBar(
                content: AutoSizeText(S.of(context).link_exists),
                duration: const Duration(seconds: 3),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            final id = FirebaseAuth.instance.currentUser?.uid;

            final newLink = AppLink(
              type: type,
              text: name,
              value: link,
            );

            folder.appLinks.add(newLink);
            await FirebaseApi.updateUserById(user: user, id: id);
          },
        );
      },
    );
  }
}
