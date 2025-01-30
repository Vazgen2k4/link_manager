import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/calc/calc_bloc.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
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
      child: const Text("Добавить"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              children: [
                CalcCardWidget(
                  text: "Средний балл",
                  type: CalcType.awg,
                ),
                CalcCardWidget(
                  text: "Кредиты",
                  type: CalcType.sumGrades,
                ),
                CalcCardWidget(
                  text: "Взвешенный балл",
                  type: CalcType.weightedAwg,
                ),
                CalcCardWidget(
                  text: "Взвешенные кредиты",
                  type: CalcType.sumWeightGrades,
                ),
              ],
            ),
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
                  spacing: 22,
                  children: [
                    if (grades.isEmpty)
                      Expanded(
                        child: Text(
                          "Нет оценок",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.text.withAlpha(50),
                            fontSize: 22,
                          ),
                        ),
                      ),
                    if (grades.isNotEmpty)
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
                          separatorBuilder: (_, __) =>
                              const SizedBox.square(dimension: 12),
                          itemCount: grades.length,
                        ),
                      ),
                    _buildAddButton(context),
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

class CalcCardWidget extends StatelessWidget {
  final String text;

  final CalcType type;

  const CalcCardWidget({
    super.key,
    required this.text,
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
    return Card.filled(
      color: AppColors.main,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
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
    );
  }
}

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
          if (value == weightedGrade || value == null) {
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
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: TextEditingController(
          text: weightedGrade.credit == 0
              ? null
              : weightedGrade.credit.toString(),
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
          hintText: "Кредиты",
        ),
      ),
    );
  }
}
