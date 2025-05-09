import 'package:flutter/material.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class AppCardWidget extends StatelessWidget {
  const AppCardWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
