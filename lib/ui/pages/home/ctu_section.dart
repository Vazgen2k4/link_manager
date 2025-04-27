import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/widgets/buttons/cart_btn.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class CTUSection extends StatelessWidget {
  const CTUSection({
    super.key,
    required this.hasWrap,
  });

  final bool hasWrap;

  @override
  Widget build(BuildContext context) {
    return Section(
      title: S.of(context).ctu_section_title,
      verticalPadding: 10,
      contentSpace: 15,
      child: SizedBox(
        height: hasWrap ? null : 50,
        child: StreamBuilder(
          stream: FirebaseApi.ctuLinksDoc.snapshots(),
          builder: (context, snapshot) {
            final folder = Folder.fromJson(snapshot.data?.data() ?? {});

            if (hasWrap) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: folder.appLinks.map((appLink) {
                  return CartBtn(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(appLink.text ?? 'error'),
                          const SizedBox(width: 12),
                          Icon(getIconByLinkType(appLink.type))
                        ],
                      ),
                    ),
                    onClick: () => launchUrlByLink(appLink.value),
                  );
                }).toList(),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: folder.appLinks.length,
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (_, index) {
                final appLink = folder.appLinks[index];
                return CartBtn(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(appLink.text ?? 'error'),
                      const SizedBox(width: 12),
                      Icon(getIconByLinkType(appLink.type))
                    ],
                  ),
                  onClick: () => launchUrlByLink(appLink.value),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
