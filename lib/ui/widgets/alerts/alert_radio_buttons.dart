import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:flutter/material.dart';

class AlertRadioButtons extends StatelessWidget {
  final void Function(Set<AppLinkType> type)? onChanged;
  final AppLinkType linkType;
  const AlertRadioButtons({
    super.key,
    this.onChanged,
    required this.linkType,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AppLinkType>(
      onSelectionChanged: onChanged,
      style: ButtonStyle(
        shape: getProperty(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      segments: const [
        ButtonSegment(
          icon: Icon(Icons.link),
          value: AppLinkType.link,
        ),
        ButtonSegment(
          icon: Icon(Icons.email),
          value: AppLinkType.email,
        ),
        ButtonSegment(
          icon: Icon(Icons.phone),
          value: AppLinkType.phone,
        ),
      ],
      selected: {linkType},
    );
  }
}
