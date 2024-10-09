import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:flutter/material.dart';

class AlertRadioButtons extends StatelessWidget {
  final void Function(Set<AppLinkType> type)? onChanged;
  final AppLinkType linkType;
  final bool withNone;

  const AlertRadioButtons({
    super.key,
    this.onChanged,
    required this.linkType,
    this.withNone = false,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AppLinkType>(
      onSelectionChanged: onChanged,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      segments: [
        if (withNone) ...[
          ButtonSegment(
            icon: Icon(Icons.folder_rounded),
            value: AppLinkType.none,
          ),
        ],
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
