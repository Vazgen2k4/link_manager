import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/ui/widgets/card/app_card_widget.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClick;

  const SettingsButton({
    super.key,
    required this.text,
    required this.icon,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: AppCardWidget(
        child: Row(
          spacing: 12,
          children: [Icon(icon), AutoSizeText(text)],
        ),
      ),
    );
  }
}
