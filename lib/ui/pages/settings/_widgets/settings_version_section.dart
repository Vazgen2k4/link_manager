import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/cubit/version_cubit.dart';
import 'package:link_manager/ui/widgets/card/app_card_widget.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class SettingsVersionSection extends StatelessWidget {
  const SettingsVersionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: S.of(context).version_section_title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          BlocSelector<VersionCubit, VersionCubitState, String?>(
            selector: (state) => state.version,
            builder: (context, version) {
              if (version == null) {
                return SizedBox.shrink();
              }

              return AppCardWidget(
                child: Row(
                  spacing: 16,
                  children: [
                    Icon(Icons.code),
                    Text(
                      S.of(context).version_is(version),
                    ),
                  ],
                ),
              );
            },
          ),
          BlocSelector<VersionCubit, VersionCubitState, String?>(
              selector: (state) => state.buildNumber,
              builder: (context, buildNumber) {
                if (buildNumber == null) {
                  return SizedBox.shrink();
                }

                return AppCardWidget(
                  child: Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.code),
                      Text(
                        S.of(context).build_is(buildNumber),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
