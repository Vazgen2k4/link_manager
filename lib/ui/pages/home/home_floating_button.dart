import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/logic.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';

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
