import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget? child;
  final CrossAxisAlignment crossAxisAlignment;
  final double verticalPadding;
  final double contentSpace;

  const Section({
    super.key,
    required this.title,
    this.child,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.verticalPadding = 20,
    this.contentSpace = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          SizedBox(height: contentSpace),
          if (child != null) child as Widget,
        ],
      ),
    );
  }
}
