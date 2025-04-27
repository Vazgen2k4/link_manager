import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/pages/profile/profile_tab.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).profile_page_title,
        isProfilePage: true,
      ),
      body: const ProfileTab(),
    );
  }
}
