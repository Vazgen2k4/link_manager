import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/resources/resources.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/limited_container/limited_container.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  void setLanguage(BuildContext context, String lang) {
    context.read<SettingsBloc>().add(SettingsEventSetLocale(newLang: lang));
  }

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
            child: Section(
              title: S.of(context).lang,
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.main.withAlpha(33),
                      border: Border.all(
                        color: AppColors.main,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: AppColors.main,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Icon(Icons.language),
                                  const SizedBox(width: 19),
                                  AutoSizeText(S.of(context).current_lang),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            divider,
                            IconButton(
                              isSelected: lang == 'ru',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'ru'),
                              icon: Image.asset(
                                AppImages.ru,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            IconButton(
                              isSelected: lang == 'cs',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'cs'),
                              icon: Image.asset(
                                AppImages.cz,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            IconButton(
                              isSelected: lang == 'en',
                              style: buttonStyle,
                              onPressed: () => setLanguage(context, 'en'),
                              icon: Image.asset(
                                AppImages.en,
                                fit: BoxFit.cover,
                                width: 25,
                              ),
                            ),
                            divider,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Section(
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
                          title: "Move CTU Links",
                          isChecked: state.moveCTULinks,
                          onChanged: (newValue) {
                            context.read<SettingsBloc>().add(ToggleMoveCTULinksEvent());
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.divider,
    required this.icon,
    required this.title,
    required this.onChanged,
    required this.isChecked,
  });

  final SizedBox divider;
  final IconData icon;
  final String title;
  final ValueChanged<bool> onChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.main.withAlpha(33),
        border: Border.all(
          color: AppColors.main,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.main,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(icon),
                    const SizedBox(width: 19),
                    AutoSizeText(title),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              divider,
              Switch(
                value: isChecked,
                onChanged: onChanged,
              ),
              divider,
            ],
          ),
        ],
      ),
    );
  }
}
