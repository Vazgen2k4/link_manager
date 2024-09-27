import 'package:link_manager/logic/middleware/middleware.dart';
import 'package:link_manager/ui/pages/profile/profile_page_content.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Middleware(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
          isProfilePage: true,
        ),
        body: ProfilePageContent(),
      ),
    );
  }
}
