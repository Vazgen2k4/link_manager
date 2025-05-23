part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsEventLoad extends SettingsEvent {
  const SettingsEventLoad();
  
  @override
  List<Object> get props => [];
}

final class SettingsEventSetLocale extends SettingsEvent {
  final String newLang;
  const SettingsEventSetLocale({this.newLang = 'en'});

  @override
  List<Object> get props => [newLang];
}
