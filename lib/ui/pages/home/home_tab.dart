import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/ui/pages/home/ctu_section.dart';
import 'package:link_manager/ui/widgets/buttons/to_kos_button.dart';
import 'package:link_manager/ui/widgets/lists/folders_widget_list.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return SizedBox.shrink();
          }

          return CustomScrollView(
            slivers: [
              if (state.showKOSButton) SliverToBoxAdapter(child: const ToKosButton()),
              if (state.showCTULinks) ...[
                SliverToBoxAdapter(child: CTUSection(hasWrap: state.moveCTULinks)),
                SliverToBoxAdapter(child: Divider()),
              ],
              SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: FoldersWidgetList()),
            ],
          );
        },
      ),
    );
  }
}
