import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

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
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.main,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 12,
            children: [Icon(icon), AutoSizeText(text)],
          ),
        ),
      ),
    );
  }
}
