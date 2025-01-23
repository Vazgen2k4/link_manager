import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/logic.dart';

import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/buttons/cart_btn.dart';

import 'package:link_manager/ui/widgets/buttons/to_kos_button.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:link_manager/ui/widgets/lists/folders_widget_list.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Middleware(
      child: Scaffold(
        appBar: CustomAppBar(
          isHomePage: true,
          title: S.of(context).home_page_title,
        ),
        body: const Padding(
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
        floatingActionButton: const HomeFloatingButton(),
      ),
    );
  }
}

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userStream = FirebaseApi.users.doc(uid).snapshots();

    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) {
          return AutoSizeText(S.of(context).floating_error);
        }

        AppUserRole role = AppUserRole.user;

        try {
          role = AppUserRole.values.byName(data.get('role') as String);
        } catch (e) {
          AppLogger.logWarning("Нет роли у пользователя или неверный тип роли");
          AppLogger.logWarning("Установка роли простого пользователя");
          role = AppUserRole.user;
        }

        return Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (role == AppUserRole.admin) ...[
              FloatingActionButton(
                heroTag: AppHeroTags.settingsButton,
                child: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
            FloatingActionButton(
              heroTag: AppHeroTags.calculateFAB,
              child: const Icon(Icons.calculate),
              onPressed: () => goRoute(context, AppRoutes.calc),
            ),
            FloatingActionButton(
              heroTag: AppHeroTags.button,
              child: const Icon(Icons.add),
              onPressed: () async {
                await AppDialogs.addFolderDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class CTUSection extends StatelessWidget {
  const CTUSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: S.of(context).ctu_section_title,
      verticalPadding: 10,
      contentSpace: 15,
      child: SizedBox(
        height: 50,
        child: StreamBuilder(
          stream: FirebaseApi.ctuLinksDoc.snapshots(),
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
                      AutoSizeText(appLink.text ?? 'error'),
                      const SizedBox(width: 12),
                      Icon(getIconByLinkType(appLink.type))
                    ],
                  ),
                  onClick: () => launchUrlByLink(appLink.value),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
