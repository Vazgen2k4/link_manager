import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';

class CalcInputWidget extends StatelessWidget {
  final CalcWeightedGrade weightedGrade;
  final int index;

  const CalcInputWidget({
    super.key,
    required this.weightedGrade,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(signed: true),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: TextEditingController(
          text: weightedGrade.credit == 0 ? null : weightedGrade.credit.toString(),
        ),
        onSubmitted: (value) {
          AppLogger.logInfo("Изменение кредитов на $value");
          value = value.trim();

          context.read<CalcBloc>().add(
                CalcSetGrade(
                  index,
                  weightedGrade.copyWith(
                    credit: int.tryParse(value) ?? 0,
                  ),
                ),
              );
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),
          hintText: S.of(context).calc_credits,
        ),
      ),
    );
  }
}
