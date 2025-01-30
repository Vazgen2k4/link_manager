import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppHeroTags.settingsButton,
      child: Scaffold(
        appBar: CustomAppBar(
          isHomePage: true,
          title: S.of(context).settings_page_title,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
