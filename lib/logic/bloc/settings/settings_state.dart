part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial() : super();
}

final class SettingsLoaded extends SettingsState {
  final String _lang;
  final bool _showKOSButton;
  final bool _showCTULinks;
  final bool _hasWrapCTULinks;

  String get lang => _lang;
  bool get showKOSButton => _showKOSButton;
  bool get showCTULinks => _showCTULinks;
  bool get moveCTULinks => _hasWrapCTULinks;

  const SettingsLoaded({
    String? lang,
    bool? showKOSButton,
    bool? showCTULinks,
    bool? hasWrapCTULinks,
  })  : _lang = lang ?? 'en',
        _showKOSButton = showKOSButton ?? true,
        _showCTULinks = showCTULinks ?? true,
        _hasWrapCTULinks = hasWrapCTULinks ?? false;

  @override
  List<Object> get props => [_lang, _showKOSButton, _showCTULinks, _hasWrapCTULinks];
}
