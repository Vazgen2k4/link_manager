import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.divider,
    required this.icon,
    required this.title,
    required this.onChanged,
    required this.isChecked,
  });

  final SizedBox divider;
  final IconData icon;
  final String title;
  final ValueChanged<bool> onChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.main.withAlpha(33),
        border: Border.all(
          color: AppColors.main,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.main,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(icon),
                    const SizedBox(width: 16),
                    AutoSizeText(title),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              divider,
              Switch(
                value: isChecked,
                onChanged: onChanged,
              ),
              divider,
            ],
          ),
        ],
      ),
    );
  }
}
