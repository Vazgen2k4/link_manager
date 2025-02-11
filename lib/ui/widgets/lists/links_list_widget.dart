import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/lists/list_links_content_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinksListWidget extends StatelessWidget {
  final Folder folder;
  final int index;
  final double minHeight;
  final double maxHeight;

  const LinksListWidget({
    super.key,
    required this.folder,
    required this.index,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final links = folder.appLinks;
    const double contentHeight = 36;

    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: maxHeight,
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: minHeight - 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        folder.name ?? S.of(context).error_name,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox.square(
                    dimension: contentHeight,
                    child: IconButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed: () => deleteFolder(context),
                      icon: const Icon(Icons.delete_sweep_rounded),
                    ),
                  ),
                  SizedBox.square(dimension: 4),
                  SizedBox.square(
                    dimension: contentHeight,
                    child: IconButton.filled(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add_box_outlined),
                      onPressed: () async {
                        await AppDialogs.addLinkToFolderDialog(context, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // divider,
            SizedBox(height: 8),
            SizedBox(
              height: 36,
              width: double.infinity,
              child: LInksListContentWidget(
                links: links,
                folderIndex: index,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickFolder() async {
    AppLogger.logInfo('Нажатие на ссылку');
    final link = folder.link;

    if (link == null || link.isEmpty) {
      AppLogger.logWarning('Обнаружена пустая ссылка');
      return;
    }
  }

  void deleteFolder(BuildContext context) async {
    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.currentUser;

    if (user == null) {
      return;
    }

    final haveApprovement = await AppDialogs.getApprovement(
      context,
      "${S.of(context).remove_folder} \"${user.folders[index].name}\"?",
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
