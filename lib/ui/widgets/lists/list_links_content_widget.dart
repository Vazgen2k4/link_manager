import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
      return const Expanded(
        child: Align(
          child: Text('Директория пуста'),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(link.text ?? 'error'),
                      const SizedBox(width: 15),
                      Icon(getIconDataByAppLink(link), size: 22),
                    ],
                  ),
                ),
                onLongPress: () => deleateLink(context, index),
                onTap: () async {
                  final urlStr = link.value;
                  if (urlStr == null) {
                    return;
                  }
                  final url = Uri.parse(urlStr);
                  await launchUrl(url);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void deleateLink(BuildContext context, int index) async {
    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.curentUser;

    if (user == null) {
      return;
    }

    final linkText = user.folders[folderIndex].appLinks[index].text;
    final haveApprovement = await AppDialogs.getApprovement(
      context,
      "Вы уверены, что хотите удалить ссылку: \"$linkText\"?",
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
