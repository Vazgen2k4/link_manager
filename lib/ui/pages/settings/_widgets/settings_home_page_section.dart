import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/pages/settings/_widgets/settings_tile.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class SettingsHomePageSection extends StatelessWidget {
  const SettingsHomePageSection({
    super.key,
    required this.divider,
  });

  final SizedBox divider;

  @override
  Widget build(BuildContext context) {
    return Section(
      title: S.of(context).settings_home_page_section,
      child: Column(
        spacing: 16,
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return SettingsTile(
                  divider: divider,
                  icon: Icons.keyboard,
                  title: S.of(context).show_kos_button,
                  isChecked: state.showKOSButton,
                  onChanged: (newValue) {
                    context.read<SettingsBloc>().add(ToggleKOSButtonEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return SettingsTile(
                  divider: divider,
                  icon: Icons.link,
                  title: S.of(context).show_ctu_links,
                  isChecked: state.showCTULinks,
                  onChanged: (newValue) {
                    context.read<SettingsBloc>().add(ToggleCTULinksEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return SettingsTile(
                  divider: divider,
                  icon: Icons.transfer_within_a_station,
                  title: S.of(context).wrap_ctu_links,
                  isChecked: state.moveCTULinks,
                  onChanged: (newValue) {
                    context.read<SettingsBloc>().add(ToggleMoveCTULinksEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return SettingsTile(
                  divider: divider,
                  icon: Icons.people_alt,
                  title: S.of(context).show_ntk_people,
                  isChecked: state.showNTKPeopleCount,
                  onChanged: (newValue) {
                    context.read<SettingsBloc>().add(ToggleNTKPeopleCountEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
