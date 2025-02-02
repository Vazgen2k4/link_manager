import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/resources/resources.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/pages/profile/personal_form.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/buttons/cooldown_button.dart';
import 'package:link_manager/ui/widgets/buttons/settings_button.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  void support(BuildContext context) {
    // Clipboard.setData(
    //   const ClipboardData(
    //     text: '2957569016/3030',
    //   ),
    // );
    
    launchUrl(Uri.parse(kSupportUrl));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.correct,
        content: AutoSizeText(
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
    const divider = SizedBox(height: 8, width: 8);
    final lang = (context.read<SettingsBloc>().state as SettingsLoaded).lang;

    final buttonStyle = ButtonStyle(
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      // st - стейт, относительно его выбираем цвет
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (st) => st.contains(WidgetState.selected) ? AppColors.main : null,
      ),
    );
    return LimitContainer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Section(
              title: S.of(context).userdata_section_title,
              child: const PersonalForm(),
            ),
          ),
          SliverToBoxAdapter(
            child: Section(
              title: S.of(context).dev_section_title,
              child: Column(
                children: [
                  SettingsButton(
                    icon: Icons.favorite,
                    text: S.of(context).support_project,
                    onClick: () => support(context),
                  ),
                  divider,
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
          ),
          SliverToBoxAdapter(
            child: Section(
              title: S.of(context).settings_title,
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.main.withAlpha(33),
                      border: Border.all(
                        color: AppColors.main,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: AppColors.main,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Icon(Icons.language),
                                  const SizedBox(width: 19),
                                  AutoSizeText(S.of(context).lang),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            divider,
                            IconButton(
                              isSelected: lang == 'ru',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'ru'),
                              icon: Image.asset(
                                AppImages.ru,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            IconButton(
                              isSelected: lang == 'cs',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'cs'),
                              icon: Image.asset(
                                AppImages.cz,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            IconButton(
                              isSelected: lang == 'en',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'en'),
                              icon: Image.asset(
                                AppImages.en,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            divider,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Section(
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
          ),
        ],
      ),
    );
  }
}
