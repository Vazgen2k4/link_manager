import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/middleware/middleware.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/buttons/cart_btn.dart';

import 'package:link_manager/ui/widgets/buttons/to_kos_button.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:link_manager/ui/widgets/lists/folders_widget_list.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Middleware(
      child: Scaffold(
        appBar: CustomAppBar(
          isHomePage: true,
          title: 'Link Manager',
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToKosButton(),
              CTUSection(),
              Divider(),
              SizedBox(height: 12),
              Expanded(child: FoldersWidgetList()),
            ],
          ),
        ),
        floatingActionButton: HomeFloattingButton(),
      ),
    );
  }
}

class HomeFloattingButton extends StatelessWidget {
  const HomeFloattingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseApi.users
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const Text("Ошибка с кнопками");
          }

          AppUserRole role = AppUserRole.user;

          try {
            role = AppUserRole.values.byName(data.get('role') as String);
          } catch (e) {
            if (kDebugMode) {
              print("Нет роли у пользователя или неверный тип роли");
              print("Установка роли простого пользователя");
            }

            role = AppUserRole.user;
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (role == AppUserRole.admin) ...[
                FloatingActionButton(
                  heroTag: AppHeroTags.settingsButton,
                  child: const Icon(Icons.settings),
                  onPressed: () {},
                ),
                const SizedBox(width: 12)
              ],
              FloatingActionButton(
                heroTag: AppHeroTags.button,
                child: const Icon(Icons.add),
                onPressed: () async {
                  await AppDialogs.addFolderDialog(context);
                },
              ),
            ],
          );
        });
  }
}

class CTUSection extends StatelessWidget {
  const CTUSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'ČVUT - FEL',
      verticalPadding: 10,
      contentSpace: 15,
      child: SizedBox(
        height: 50,
        child: StreamBuilder(
          stream: FirebaseApi.ctuLiknsDoc.snapshots(),
          builder: (context, snapshot) {
            final folder = Folder.fromJson(snapshot.data?.data() ?? {});

            return ListView.separated(
              shrinkWrap: true,
              itemCount: folder.appLinks.length,
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (_, index) {
                final appLink = folder.appLinks[index];
                return CartBtn(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(appLink.text ?? 'error'),
                      const SizedBox(width: 12),
                      Icon(getIconDataByAppLink(appLink))
                    ],
                  ),
                  onClick: () async {
                    String link = appLink.value ?? '';
                    Uri url = Uri.parse(link);
                    await launchUrl(url);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
