import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final bool isHomePage;
  final bool isProfilePage;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title,
    this.isHomePage = false,
    this.isProfilePage = false,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userUrl = user?.photoURL ?? '';

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.main,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: <Widget>[
              if (!isHomePage) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    size: 32,
                  ),
                ),
              ],
              Expanded(
                // flex: 3,
                child: AutoSizeText(
                  title ?? S.of(context).no_title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              if (!isProfilePage) ...[
                Center(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.search),
                    icon: Icon(Icons.search),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
