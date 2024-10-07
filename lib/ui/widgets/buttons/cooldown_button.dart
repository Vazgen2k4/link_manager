import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CooldownButton extends StatefulWidget {
  final VoidCallback? onClick;
  final Widget? child;

  const CooldownButton({
    super.key,
    this.onClick,
    this.child,
  });

  CooldownButton.text({
    super.key,
    this.onClick,
    required String text,
  })  : child = AutoSizeText(text);

  @override
  State<CooldownButton> createState() => _CooldownButtonState();
}

class _CooldownButtonState extends State<CooldownButton> {
  bool isPresed = false;

  @override
  Widget build(BuildContext context) {
    Widget? current = isPresed ? loadWidget : widget.child;



    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: getProperty(AppColors.main),
          minimumSize: getProperty(const Size(50, 20)),
          maximumSize: getProperty(const Size(double.maxFinite, 60)),
          padding: getProperty(
            const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
          ),
        ),
        onPressed: action,
        child: Center(
          child: current,
        ),
      ),
    );
  }

  void action() async {
    if (isPresed || widget.onClick == null) {
      return;
    }

    setState(() {
      isPresed = true;
    });

    widget.onClick!();
  }


}
