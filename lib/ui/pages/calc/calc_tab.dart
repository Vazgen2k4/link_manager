import 'package:flutter/material.dart';
import 'package:link_manager/ui/pages/calc/calc_list_widget.dart';

class CalcTab extends StatelessWidget {
  const CalcTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CalcListWidget(),
    );
  }
}
