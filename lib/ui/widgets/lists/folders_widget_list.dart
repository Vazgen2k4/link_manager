import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/ui/widgets/lists/reordered_folder_list.dart';

class FoldersWidgetList extends StatelessWidget {
  const FoldersWidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
      stream: FirebaseApi.users.doc(userId).snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();

        if (data == null) {
          return const Center(child: LinearProgressIndicator());
        }
        final user = AppUser.fromJson(data);
        
        if (user.folders.isEmpty) {
          return Center(
            child: AutoSizeText(S.of(context).no_folders),
          );
        }

        return ReorderedFolderList(key: UniqueKey(), user: user);
      },
    );
  }
}
