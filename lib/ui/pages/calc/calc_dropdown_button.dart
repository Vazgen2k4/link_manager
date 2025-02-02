import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcDropdownButton extends StatelessWidget {
  CalcDropdownButton({
    super.key,
    this.width = 55.0 * 1.5,
    required this.index,
    required this.weightedGrade,
  });

  final double width;
  final int index;
  final CalcWeightedGrade weightedGrade;

  final List<DropdownMenuItem<CalcGrade>> _letters = [
    CalcGrade.A,
    CalcGrade.B,
    CalcGrade.C,
    CalcGrade.D,
    CalcGrade.E,
    CalcGrade.F,
    CalcGrade.none,
  ]
      .map(
        (e) => DropdownMenuItem<CalcGrade>(
          value: e,
          child: Center(child: Text(e.name)),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.main,
            width: 2,
          ),
        ),
      ),
      child: DropdownButton<CalcGrade>(
        items: _letters,
        underline: SizedBox(),
        onChanged: (CalcGrade? value) {
          if ( value == null || value == weightedGrade.grade) {
            AppLogger.logWarning(
              "Значение не изменилось или равно null, value: $value",
            );
            return;
          }

          context
              .read<CalcBloc>()
              .add(CalcSetGrade(index, weightedGrade.copyWith(grade: value)));
        },
        value: weightedGrade.grade,
      ),
    );
  }
}
