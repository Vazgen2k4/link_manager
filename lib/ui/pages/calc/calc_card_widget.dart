import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class CalcCardWidget extends StatelessWidget {
  final String text;

  final CalcType type;

  const CalcCardWidget({
    super.key,
    this.text = "^_^",
    required this.type,
  });

  num _getValue(CalcInitial state) => switch (type) {
        CalcType.weightedAwg => state.calcWeightedAvg(),
        CalcType.sumGrades => state.sumCredits(),
        CalcType.sumWeightGrades => state.sumWeightGrades(),
        CalcType.awg => state.calcAwg(),
      };

  int _getFractionDigits() => switch (type) {
        CalcType.weightedAwg => 2,
        CalcType.sumGrades => 0,
        CalcType.sumWeightGrades => 0,
        CalcType.awg => 2,
      };

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      child: Card.filled(
        color: AppColors.main,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<CalcBloc, CalcState>(
                  builder: (context, state) {
                    if (state is! CalcInitial) {
                      return const SizedBox();
                    }

                    return AnimatedFlipCounter(
                      value: _getValue(state),
                      fractionDigits: _getFractionDigits(),
                      duration: const Duration(milliseconds: 500),
                      textStyle: const TextStyle(fontSize: 22),
                    );
                  },
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
