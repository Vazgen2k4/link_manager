import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LInksListContentWidget extends StatelessWidget {
  const LInksListContentWidget({
    super.key,
    required this.links,
    required this.folderIndex,
  });

  final List<AppLink> links;
  final int folderIndex;

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) {
      return Align(
        child: AutoSizeText(S.of(context).empty_folder),
      );
    }

    return ListView.separated(
      controller: ScrollController(),
      shrinkWrap: true,
      itemCount: links.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, index) {
        final link = links[index];
    
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff594391),
            child: InkWell(
              
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(link.text ?? S.of(context).error_name),
                      const SizedBox(width: 15),
                      Icon(getIconByLinkType(link.type), size: 22),
                    ],
                  ),
                ),
              ),
              onLongPress: () => deleteLink(context, index),
              onTap: () => launchUrlByLink(link.value),
            ),
          ),
        );
      },
    );
  }

  void deleteLink(BuildContext context, int index) async {
    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.currentUser;

    if (user == null) {
      return;
    }

    final linkText = user.folders[folderIndex].appLinks[index].text;
    final haveApprovement = await AppDialogs.getApprovement(
      context,
      "${S.of(context).remove_link} \"$linkText\"?",
    );

    if (haveApprovement == null || !haveApprovement) {
      return;
    }

    if (index >= user.folders[folderIndex].appLinks.length) {
      return;
    }

    user.folders[folderIndex].appLinks.removeAt(index);

    await FirebaseApi.updateUserById(
      user: user,
      id: FirebaseAuth.instance.currentUser?.uid,
    );
  }
}
