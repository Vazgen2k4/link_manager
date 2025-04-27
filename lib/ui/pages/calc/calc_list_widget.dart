import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/ui/pages/calc/calc_card_widget.dart';
import 'package:link_manager/ui/pages/calc/calc_item_widget.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class CalcListWidget extends StatelessWidget {
  const CalcListWidget({
    super.key,
  });

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        AppLogger.logInfo("Добавление нового элемента");
        context.read<CalcBloc>().add(const CalcAdd.none());
      },
      child: Text(S.of(context).add_grade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          Wrap(
            children: [
              CalcCardWidget(
                text: S.of(context).calc_gpa,
                type: CalcType.awg,
              ),
              CalcCardWidget(
                text: S.of(context).calc_weighted_average,
                type: CalcType.weightedAwg,
              ),
              CalcCardWidget(
                text: S.of(context).calc_credits,
                type: CalcType.sumGrades,
              ),
              CalcCardWidget(
                text: S.of(context).calc_weighted,
                type: CalcType.sumWeightGrades,
              ),
            ],
          ),
          BlocSelector<CalcBloc, CalcState, List<CalcWeightedGrade>>(
            selector: (state) {
              if (state is! CalcInitial) {
                return [];
              }

              return state.grades;
            },
            builder: (context, grades) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (grades.isEmpty) ...[
                      Expanded(
                        child: Text(
                          S.of(context).have_no_grades,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.text.withAlpha(50),
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                    if (grades.isNotEmpty) ...[
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CalcItemWidget(
                              key: ValueKey(grades[index].hashCode),
                              index: index,
                              weightedGrade: grades[index],
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox.square(dimension: 12),
                          itemCount: grades.length,
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                    _buildAddButton(context),
                    SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
