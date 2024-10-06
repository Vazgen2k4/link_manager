import 'package:flutter/services.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/buttons/cooldown_button.dart';
import 'package:link_manager/ui/widgets/buttons/profile_btn.dart';
import 'package:link_manager/ui/widgets/buttons/settings_button.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  void copyData(BuildContext context) {
    Clipboard.setData(
      const ClipboardData(
        text: '2957569016/3030',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // TODO: вынести цвет
        backgroundColor: const Color.fromARGB(255, 30, 159, 101),
        content: Text(
          S.of(context).support_response_msg,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void setLanguage(BuildContext context, String lang) {
    context.read<SettingsBloc>().add(SettingsEventSetLocale(newLang: lang));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heigth = size.height - kToolbarHeight - kTextTabBarHeight;

    return LimitContainer(
      child: SizedBox(
        height: heigth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Section(
                title: S.of(context).userdata_section_title,
                child: const PersonalForm(),
              ),
              Section(
                title: S.of(context).dev_section_title,
                child: Column(
                  children: [
                    SettingsButton(
                      icon: Icons.favorite,
                      text: S.of(context).support_project,
                      onClick: () => copyData(context),
                    ),
                    const SizedBox(height: 8),
                    SettingsButton(
                      icon: Icons.telegram,
                      text: S.of(context).telegram_blog,
                      onClick: () {
                        launchUrl(Uri.parse('https://t.me/OverWebBlog'));
                      },
                    ),
                  ],
                ),
              ),
              Section(
                title: S.of(context).settings_title,
                child: Column(
                  children: [
                    SettingsButton(
                      text: 'Русский',
                      icon: Icons.local_parking_sharp,
                      onClick: () => setLanguage(context, 'ru'),
                    ),
                    SettingsButton(
                      text: 'Английский',
                      icon: Icons.local_parking_sharp,
                      onClick: () => setLanguage(context, 'en'),
                    ),
                    SettingsButton(
                      text: 'Чешский',
                      icon: Icons.local_parking_sharp,
                      onClick: () => setLanguage(context, 'cz'),
                    ),
                  ],
                ),
              ),
              Section(
                title: S.of(context).exit,
                child: Hero(
                  tag: AppHeroTags.button,
                  child: CooldownButton.text(
                    text: S.of(context).exit,
                    onClick: () async {
                      context.read<AuthBloc>().add(const AuthLogOut());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            disabel: true,
            radius: 50,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(user?.displayName ?? ''),
        ),
        const SizedBox(width: 15),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(user?.email ?? ''),
        ),
      ],
    );
  }
}
