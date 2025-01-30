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

  final _square = 55.0;

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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          CalcCardWidget(value: 1.45, text: "Баллов"),
          CalcCardWidget(value: 120, text: "Кредитов"),
          Row(
            spacing: 12,
            children: [
              SizedBox(
                width: _square * 1.5,
                child: const Text("Оценка"),
              ),
              const Text("Кредиты"),
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
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (grades.isEmpty)
                    const Text("Список пуст", textAlign: TextAlign.center),
                  if (grades.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CalcItemWidget(key: ValueKey(index));
                      },
                      separatorBuilder: (_, __) =>
                          const SizedBox.square(dimension: 12),
                      itemCount: grades.length,
                    ),
                  _buildAddButton(context),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CalcCardWidget extends StatefulWidget {
  final double value;
  final String text;

  const CalcCardWidget({
    super.key,
    required this.value,
    required this.text,
  });

  @override
  State<CalcCardWidget> createState() => _CalcCardWidgetState();
}

class _CalcCardWidgetState extends State<CalcCardWidget> {
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppLogger.logInfo("Нажатие на карточку");
        setState(() {
          _value = _value + 1.3;
        });
      },
      onDoubleTap: () {
        AppLogger.logInfo("Нажатие на карточку");
        setState(() {
          _value = _value - 1.3;
        });
      },
      child: Card.filled(
        color: AppColors.main,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedFlipCounter(
            value: _value,
            fractionDigits: 2,
            duration: const Duration(milliseconds: 500),
            suffix: ' ${widget.text}',
          ),
        ),
      ),
    );
  }
}

/* 

Text.rich(
          TextSpan(
            text: "$value",
            children: [
              TextSpan(
                text: " $text",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          style: TextStyle(
            color: AppColors.text,
            fontSize: 22,
          ),
        )

 */

class CalcItemWidget extends StatefulWidget {
  final double height;
  const CalcItemWidget({required super.key, this.height = 55.0});

  @override
  State<CalcItemWidget> createState() => _CalcItemWidgetState();
}

class _CalcItemWidgetState extends State<CalcItemWidget> {
  final List<DropdownMenuItem<CalcGrade>> _letters = [
    CalcGrade.A,
    CalcGrade.B,
    CalcGrade.C,
    CalcGrade.D,
    CalcGrade.E,
    CalcGrade.F,
    CalcGrade.none,
  ]
      .map((e) => DropdownMenuItem<CalcGrade>(
            value: e,
            child: Center(child: Text(e.name)),
          ))
      .toList();

  CalcGrade _selectedLetter = CalcGrade.none;

  @override
  Widget build(BuildContext context) {
    final width = widget.height * 1.5;

    return Slidable(
      key: widget.key!,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              AppLogger.logInfo("Удаление элемента");
              setState(() {});
            },
            icon: Icons.delete,
            backgroundColor: AppColors.error,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: SizedBox(
          height: widget.height,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.main,
                      width: 2,
                    ),
                  ),
                  // borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<CalcGrade>(
                  items: _letters,
                  underline: SizedBox(),
                  onChanged: (CalcGrade? value) {
                    if (value == _selectedLetter || value == null) {
                      AppLogger.logWarning(
                        "Значение не изменилось или равно null, value: $value",
                      );
                      return;
                    }
                    setState(() {
                      _selectedLetter = value;
                    });
                  },
                  value: _selectedLetter,
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(
                    //     color: AppColors.main,
                    //     width: 2,
                    //   ),
                    // ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(
                    //     color: AppColors.main,
                    //     width: 2,
                    //   ),
                    // ),

                    hintText: "Кредиты",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
