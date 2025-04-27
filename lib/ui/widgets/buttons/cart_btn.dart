import 'package:flutter/material.dart';
import 'package:link_manager/ui/theme/app_colors.dart';

class CartBtn extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget? child;
  const CartBtn({
    super.key,
    this.onClick,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.buttons,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        side: WidgetStatePropertyAll(
          const BorderSide(
            color: AppColors.main,
            width: 3,
          ),
        ),
        padding: WidgetStatePropertyAll(
          const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(Size.zero), 
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onClick,
      child: child != null ? child as Widget : SizedBox.shrink(),
    );
  }
}
