import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:link_manager/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_keys.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static final _prefs = SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{
        SettingsKeys.lang,
        SettingsKeys.theme,
        SettingsKeys.showKOSButton,
        SettingsKeys.showCTULinks,
        SettingsKeys.hasWrapCTULinks,
        SettingsKeys.showNTKPeopleCount,
      },
    ),
  );

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEventLoad>(_load);
    on<SettingsEventSetLocale>(_setLocale);
    on<ToggleKOSButtonEvent>(_toggleKOSButton);
    on<ToggleCTULinksEvent>(_toggleCTULinks);
    on<ToggleMoveCTULinksEvent>(_toggleMoveCTULinks);
    on<ToggleNTKPeopleCountEvent>(_toggleNTKPeopleCount);
  }

  Future<void> _load(
    SettingsEventLoad event,
    Emitter<SettingsState> emit,
  ) async {
    AppLogger.logHint("Инициализация SharedPreferences");

    final prefs = await _prefs;
    final lang = prefs.getString(SettingsKeys.lang);
    final showKOSButton = prefs.getBool(SettingsKeys.showKOSButton);
    final showCTULinks = prefs.getBool(SettingsKeys.showCTULinks);
    final hasWrapCTULinks = prefs.getBool(SettingsKeys.hasWrapCTULinks);
    final showNTKPeopleCount = prefs.getBool(SettingsKeys.showNTKPeopleCount);

    final state = SettingsLoaded(
      lang: lang,
      showKOSButton: showKOSButton,
      showCTULinks: showCTULinks,
      hasWrapCTULinks: hasWrapCTULinks,
      showNTKPeopleCount: showNTKPeopleCount,
    );

    emit(state);
  }

  Future<void> _setLocale(
    SettingsEventSetLocale event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении языка");
      return;
    }

    final prefs = await _prefs;
    final lang = prefs.getString(SettingsKeys.lang);

    if (lang == event.newLang) {
      AppLogger.logWarning("Попытка переключить язык на тот же");
      return;
    }

    AppLogger.logHint("Установка нового языка");
    await prefs.setString(SettingsKeys.lang, event.newLang);

    emit(SettingsLoaded(lang: event.newLang));
  }

  Future<void> _toggleKOSButton(
    ToggleKOSButtonEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении кнопки KOS");
      return;
    }

    final currentState = state as SettingsLoaded;
    final newState = !currentState.showKOSButton;

    AppLogger.logHint("Переключение кнопки KOS");
    await _prefs.then((prefs) => prefs.setBool(SettingsKeys.showKOSButton, newState));

    emit(SettingsLoaded(
      lang: currentState.lang,
      showKOSButton: newState,
      showCTULinks: currentState.showCTULinks,
      hasWrapCTULinks: currentState.moveCTULinks,
    ));
  }

  Future<void> _toggleCTULinks(
    ToggleCTULinksEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении CTU линков");
      return;
    }

    final currentState = state as SettingsLoaded;
    final newState = !currentState.showCTULinks;

    AppLogger.logHint("Переключение секции с CTU линками");
    await _prefs.then((prefs) => prefs.setBool(SettingsKeys.showCTULinks, newState));

    emit(SettingsLoaded(
      lang: currentState.lang,
      showKOSButton: currentState.showKOSButton,
      showCTULinks: newState,
      hasWrapCTULinks: currentState.moveCTULinks,
    ));
  }

  Future<void> _toggleMoveCTULinks(
    ToggleMoveCTULinksEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении перемещения CTU ссылок");
      return;
    }

    final currentState = state as SettingsLoaded;
    final newState = !currentState.moveCTULinks;

    AppLogger.logHint("Переключение перемещения CTU ссылок");
    await _prefs.then((prefs) => prefs.setBool(SettingsKeys.hasWrapCTULinks, newState));

    emit(SettingsLoaded(
      lang: currentState.lang,
      showKOSButton: currentState.showKOSButton,
      showCTULinks: currentState.showCTULinks,
      hasWrapCTULinks: newState,
    ));
  }

  Future<void> _toggleNTKPeopleCount(
    ToggleNTKPeopleCountEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) {
      AppLogger.logError("Ошибка состояния при переключении NTK počtu lidí");
      return;
    }

    final currentState = state as SettingsLoaded;
    final newState = !currentState.showNTKPeopleCount;

    AppLogger.logHint("Переключение отображения počtu lidí v NTK");
    await _prefs.then((prefs) => prefs.setBool(SettingsKeys.showNTKPeopleCount, newState));

    emit(SettingsLoaded(
      lang: currentState.lang,
      showKOSButton: currentState.showKOSButton,
      showCTULinks: currentState.showCTULinks,
      hasWrapCTULinks: currentState.moveCTULinks,
      showNTKPeopleCount: newState,
    ));
  }
}
