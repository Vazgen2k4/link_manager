import 'package:link_manager/generated/l10n.dart';

import 'package:link_manager/ui/pages/home/ctu_section.dart';
import 'package:link_manager/ui/pages/home/home_floating_button.dart';
import 'package:link_manager/ui/widgets/buttons/to_kos_button.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:link_manager/ui/widgets/lists/folders_widget_list.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomePage: true,
        title: S.of(context).home_page_title,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ToKosButton(),
            CTUSection(),
            Divider(),
            SizedBox(height: 12),
            Expanded(child: FoldersWidgetList()),
          ],
        ),
      ),
      floatingActionButton: const HomeFloatingButton(),
    );
  }
}
