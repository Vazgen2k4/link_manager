import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/logic.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Middleware(
      child: Scaffold(
        appBar: CustomAppBar(
          isHomePage: false,
          title: S.of(context).calc_title,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CalcListWidget(),
        ),
      ),
    );
  }
}

class CalcListWidget extends StatelessWidget {
  CalcListWidget({
    super.key,
  });

  final List<int> _items = List.generate(2, (index) => index);
  final _square = 55.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      child: Column(
        spacing: 12,
        children: [
          CalcCardWidget(value: 4.5, text: "Баллов"),
          CalcCardWidget(value: 120, text: "Кредитов"),
          Row(
            spacing: 12,
            children: [
              SizedBox(
                width: _square,
                child: const Text("Оценка"),
              ),
              const Text("Кредиты"),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return CalcItemWidget();
            },
            separatorBuilder: (_, __) => const SizedBox.square(dimension: 12),
            itemCount: _items.length + 1,
          ),
        ],
      ),
    );
  }
}

class CalcCardWidget extends StatelessWidget {
  final double value;
  final String text;

  const CalcCardWidget({
    super.key,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      
      color: AppColors.main,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text.rich(
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
        ),
      ),
    );
  }
}

class CalcItemWidget extends StatefulWidget {
  final double height;
  const CalcItemWidget({super.key, this.height = 55.0});

  @override
  State<CalcItemWidget> createState() => _CalcItemWidgetState();
}

class _CalcItemWidgetState extends State<CalcItemWidget> {
  final List<DropdownMenuItem<String>> _letters = ['A', 'B', 'C', 'D', 'E', 'F']
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Center(child: Text(e)),
          ))
      .toList();

  String _selectedLetter = 'A';

  @override
  Widget build(BuildContext context) {
    final width = widget.height * 1.5;

    return SizedBox(
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
              border: Border.all(
                color: AppColors.main,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              items: _letters,
              underline: SizedBox(),
              onChanged: (String? value) {
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.main,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.main,
                    width: 2,
                  ),
                ),
                hintText: "Кредиты",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
