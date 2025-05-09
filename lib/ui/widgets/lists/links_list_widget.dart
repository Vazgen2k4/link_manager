import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/lists/list_links_content_widget.dart';

class LinksListWidget extends StatelessWidget {
  final Folder folder;
  final int index;
  final double minHeight;
  final double maxHeight;
  final bool isOpened;
  final double verticalPadding;

  const LinksListWidget({
    super.key,
    required this.folder,
    required this.index,
    required this.minHeight,
    required this.maxHeight,
    required this.isOpened,
    required this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final links = folder.appLinks;
    final contentHeight = minHeight - 2 * verticalPadding;

    print('Content height: $contentHeight');

    return Stack(
      // shrinkWrap: true,
      // spacing: 8,
      // physics: NeverScrollableScrollPhysics(),
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: contentHeight,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontSize: isOpened ? 18 : 16,
                    fontWeight: isOpened ? FontWeight.w900 : FontWeight.w500,
                    color: AppColors.text,
                  ),
                  child: AutoSizeText(
                    folder.name ?? S.of(context).error_name,
                    maxLines: 1,
                  ),
                ),
              ),
              const Spacer(),
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox.square(
                  dimension: contentHeight,
                  child: IconButton.filled(
                    padding: EdgeInsets.zero,
                    onPressed: () => deleteFolder(context),
                    icon: const Icon(
                      Icons.delete_sweep_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ),
              SizedBox.square(dimension: 4),
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox.square(
                  dimension: contentHeight,
                  child: IconButton.filled(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 18,
                      // size: contentHeight / 2,
                    ),
                    onPressed: () async {
                      await AppDialogs.addLinkToFolderDialog(context, index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: isOpened
                  ? SizedBox(
                      key: ValueKey(links),
                      height: 48,
                      width: double.infinity,
                      child: LInksListContentWidget(
                        links: links,
                        folderIndex: index,
                      ),
                    )
                  : const SizedBox.shrink()),
        ),
      ],
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
