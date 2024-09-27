import 'package:flutter/material.dart';
import 'package:link_manager/logic/middleware/middleware.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Middleware(
      child: Hero(
        tag: AppHeroTags.settingsButton,
        child: Scaffold(
          appBar: CustomAppBar(
            isHomePage: true,
            title: 'Link Manager',
          ),
          body: Padding(
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
      ),
    );
  }
}
