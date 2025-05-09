import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/pages/settings/_widgets/_widgets.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = (context.read<SettingsBloc>().state as SettingsLoaded).lang;

    final buttonStyle = ButtonStyle(
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (st) => st.contains(WidgetState.selected) ? AppColors.main : null,
      ),
    );

    const divider = SizedBox(height: 8, width: 8);

    return LimitContainer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SettingsLanguageSection(
              divider: divider,
              buttonStyle: buttonStyle,
              lang: lang,
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsHomePageSection(
              divider: divider,
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsVersionSection(),
          ),
        ],
      ),
    );
  }
}
