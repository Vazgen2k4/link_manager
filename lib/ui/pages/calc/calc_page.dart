import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/pages/calc/calc_list_widget.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomePage: false,
        title: S.of(context).calc_title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CalcListWidget(),
      ),
    );
  }
}
