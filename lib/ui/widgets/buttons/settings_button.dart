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
    return ListTile(
      tileColor: AppColors.main,
      leading: Icon(icon),
      title: Text(text),
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      onTap: onClick,
    );
  }
}
