import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/ui/pages/calc/calc_dropdown_button.dart';
import 'package:link_manager/ui/pages/calc/calc_input_widget.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcItemWidget extends StatelessWidget {
  final double height;
  final int index;
  final CalcWeightedGrade weightedGrade;

  const CalcItemWidget({
    required super.key,
    this.height = 55.0,
    required this.index,
    required this.weightedGrade,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              AppLogger.logInfo("Удаление элемента по индексу $index");
              context.read<CalcBloc>().add(CalcRemove(index));
            },
            icon: Icons.delete,
            backgroundColor: AppColors.error,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: SizedBox(
          height: height,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CalcDropdownButton(
                index: index,
                weightedGrade: weightedGrade,
              ),
              CalcInputWidget(
                index: index,
                weightedGrade: weightedGrade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
