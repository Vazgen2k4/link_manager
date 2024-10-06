part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final String _lang;
  String get lang => _lang;

  const SettingsLoaded({
    String? lang,
  }) : _lang = lang ?? 'en';

  @override
  List<Object> get props => [_lang];
}
