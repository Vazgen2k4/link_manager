import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/widgets/buttons/profile_btn.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: AppHeroTags.profileImage,
          child: ProfileBtn(
            userUrl: user?.photoURL ?? '',
            isDisabled: true,
            radius: 50,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: AutoSizeText(user?.displayName ?? ''),
        ),
        const SizedBox(width: 15),
        ListTile(
          leading: const Icon(Icons.email),
          title: AutoSizeText(user?.email ?? ''),
        ),
      ],
    );
  }
}
