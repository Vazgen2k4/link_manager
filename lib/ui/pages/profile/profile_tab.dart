import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/pages/profile/personal_form.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/buttons/cooldown_button.dart';
import 'package:link_manager/ui/widgets/buttons/settings_button.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  void support(BuildContext context) {
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

 
  @override
  Widget build(BuildContext context) {
    const divider = SizedBox(height: 8, width: 8);
    
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
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
        ],
      ),
    );
  }
}
