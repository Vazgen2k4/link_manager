import 'package:flutter/services.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/buttons/cooldown_button.dart';
import 'package:link_manager/ui/widgets/buttons/profile_btn.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heigth = size.height - kToolbarHeight - kTextTabBarHeight;

    return LimitContainer(
      child: SingleChildScrollView(
        child: SizedBox(
          height: heigth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Section(
                title: 'Персональные данные',
                child: PersonalForm(),
              ),
              Section(
                title: 'Разработчик',
                child: Column(
                  children: [
                    ListTile(
                      tileColor: AppColors.main,
                      leading: const Icon(Icons.favorite),
                      title: const Text('Поддержать проект'),
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      onTap: () {
                        Clipboard.setData(
                          const ClipboardData(
                            text: '2957569016/3030',
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 30, 159, 101),
                            content: Text(
                              'Номер счёта скопирован ❤️',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      tileColor: AppColors.main,
                      leading: const Icon(Icons.telegram),
                      title: const Text('OverWeb - телеграм блог'),
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      onTap: () {
                        launchUrl(Uri.parse('https://t.me/OverWebBlog'));
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Section(
                title: 'Выход',
                child: Hero(
                  tag: AppHeroTags.button,
                  child: CooldownButton.text(
                    text: 'Выход',
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
