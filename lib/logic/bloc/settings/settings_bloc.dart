import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
// import 'package:link_manager/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_keys.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _prefs = SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{
        SettingsKeys.lang,
        SettingsKeys.theme,
      },
    ),
  );

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEventLoad>(_load);
    on<SettingsEventSetLocale>(_setLocale);
  }

  Future<void> _load(
    SettingsEventLoad event,
    Emitter<SettingsState> emit,
  ) async {
    AppLogger.logHint("Инициализация SharedPreferences");

    final prefs = await _prefs;
    final lang = prefs.getString(SettingsKeys.lang);
    final state = SettingsLoaded(lang: lang);

    emit(state);
  }

  Future<void> _setLocale(
    SettingsEventSetLocale event,
    Emitter<SettingsState> emit,
  ) async {
    if (this.state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении языка");
      return;
    }

    final prefs = await _prefs;
    final lang = prefs.getString(SettingsKeys.lang);
    // TODO: добавить функционал
    final state = this.state as SettingsLoaded;

    if (lang == event.newLang) {
      AppLogger.logWarning("Попытка переключить язык на тот же");
      return;
    }

    AppLogger.logHint("Установка нового языка");
    await prefs.setString(SettingsKeys.lang, event.newLang);

    emit(SettingsLoaded(lang: event.newLang));
  }
}
