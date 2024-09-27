import 'package:flutter/material.dart';

class LimitContainer extends StatelessWidget {
  final double maxWidth;
  final Widget? child;

  const LimitContainer({
    Key? key,
    this.maxWidth = 1200,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kTabLabelPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            width: maxWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
