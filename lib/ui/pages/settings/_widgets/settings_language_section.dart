import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/settings/settings_bloc.dart';
import 'package:link_manager/resources/resources.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/section/section.dart';

class SettingsLanguageSection extends StatelessWidget {
  const SettingsLanguageSection({
    super.key,
    required this.divider,
    required this.lang,
    this.buttonStyle,
  });
  
  final Widget divider;
  final String lang;
  final ButtonStyle? buttonStyle;

  void setLanguage(BuildContext context, String lang) {
    context.read<SettingsBloc>().add(SettingsEventSetLocale(newLang: lang));
  }

  @override
  Widget build(BuildContext context) {
    return Section(
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
    );
  }
}
