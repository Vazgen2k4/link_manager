import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/lists/list_links_content_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LInksListWidget extends StatelessWidget {
  const LInksListWidget({
    super.key,
    required this.folder,
    required this.index,
  });

  final Folder folder;
  final int index;

  @override
  Widget build(BuildContext context) {
    final links = folder.appLinks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: onClickFolder,
              child: AutoSizeText(
                folder.name ?? S.of(context).error_name,
              ),
            ),
            const Spacer(),
            IconButton.filled(
              onPressed: () => deleateFolder(context),
              icon: const Icon(Icons.delete_sweep_rounded),
            ),
            IconButton.filled(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () async {
                await AppDialogs.addLinkToFolderDialog(context, index);
              },
            ),
          ],
        ),
        LInksListContentWidget(
          links: links,
          folderIndex: index,
        ),
      ],
    );
  }

  void onClickFolder() async {
    final link = folder.link;

    if (link == null || link.isEmpty) {
      return;
    }

    final url = Uri.parse(link);
    await launchUrl(url);
  }

  void deleateFolder(BuildContext context) async {
    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.curentUser;

    if (user == null) {
      return;
    }

    final haveApprovement = await AppDialogs.getApprovement(
      context,
      "${S.of(context).remove_folder} \"${user.folders[index]}\"?",
    );

    if (haveApprovement == null || !haveApprovement) {
      return;
    }

    user.folders.removeAt(index);

    await FirebaseApi.updateUserById(
      user: user,
      id: FirebaseAuth.instance.currentUser?.uid,
    );
  }
}
