// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get auth_page_title {
    return Intl.message(
      'Login',
      name: 'auth_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get google_login_button {
    return Intl.message(
      'Login',
      name: 'google_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Floating error`
  String get floating_error {
    return Intl.message(
      'Floating error',
      name: 'floating_error',
      desc: '',
      args: [],
    );
  }

  /// `CTU - FEE`
  String get ctu_section_title {
    return Intl.message(
      'CTU - FEE',
      name: 'ctu_section_title',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_connection',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_page_title {
    return Intl.message(
      'Profile',
      name: 'profile_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Personal data`
  String get userdata_section_title {
    return Intl.message(
      'Personal data',
      name: 'userdata_section_title',
      desc: '',
      args: [],
    );
  }

  /// `Developer`
  String get dev_section_title {
    return Intl.message(
      'Developer',
      name: 'dev_section_title',
      desc: '',
      args: [],
    );
  }

  /// `Support the project`
  String get support_project {
    return Intl.message(
      'Support the project',
      name: 'support_project',
      desc: '',
      args: [],
    );
  }

  /// `Account number copied ❤️`
  String get support_response_msg {
    return Intl.message(
      'Account number copied ❤️',
      name: 'support_response_msg',
      desc: '',
      args: [],
    );
  }

  /// `OverWeb - Telegram blog`
  String get telegram_blog {
    return Intl.message(
      'OverWeb - Telegram blog',
      name: 'telegram_blog',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get settings_page_title {
    return Intl.message(
      'Exit',
      name: 'settings_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Page not found`
  String get error_404_title {
    return Intl.message(
      'Page not found',
      name: 'error_404_title',
      desc: '',
      args: [],
    );
  }

  /// `Error 404`
  String get error_404 {
    return Intl.message(
      'Error 404',
      name: 'error_404',
      desc: '',
      args: [],
    );
  }

  /// `Add Directory`
  String get add_folder {
    return Intl.message(
      'Add Directory',
      name: 'add_folder',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get field_lable_name {
    return Intl.message(
      'Name',
      name: 'field_lable_name',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get field_lable_link {
    return Intl.message(
      'Link',
      name: 'field_lable_link',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get validate_required {
    return Intl.message(
      'This field is required',
      name: 'validate_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid link format`
  String get validate_link {
    return Intl.message(
      'Invalid link format',
      name: 'validate_link',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone format`
  String get validate_phone {
    return Intl.message(
      'Invalid phone format',
      name: 'validate_phone',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get validate_email {
    return Intl.message(
      'Invalid email format',
      name: 'validate_email',
      desc: '',
      args: [],
    );
  }

  /// `Link to schedule`
  String get link_to_kos {
    return Intl.message(
      'Link to schedule',
      name: 'link_to_kos',
      desc: '',
      args: [],
    );
  }

  /// `No title`
  String get no_title {
    return Intl.message(
      'No title',
      name: 'no_title',
      desc: '',
      args: [],
    );
  }

  /// `You have no directories yet...`
  String get no_folders {
    return Intl.message(
      'You have no directories yet...',
      name: 'no_folders',
      desc: '',
      args: [],
    );
  }

  /// `Links`
  String get links {
    return Intl.message(
      'Links',
      name: 'links',
      desc: '',
      args: [],
    );
  }

  /// `Error with name`
  String get error_name {
    return Intl.message(
      'Error with name',
      name: 'error_name',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the folder:`
  String get remove_folder {
    return Intl.message(
      'Do you want to delete the folder:',
      name: 'remove_folder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the link:`
  String get remove_link {
    return Intl.message(
      'Are you sure you want to delete the link:',
      name: 'remove_link',
      desc: '',
      args: [],
    );
  }

  /// `The directory is empty`
  String get empty_folder {
    return Intl.message(
      'The directory is empty',
      name: 'empty_folder',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Deletion`
  String get deleate {
    return Intl.message(
      'Deletion',
      name: 'deleate',
      desc: '',
      args: [],
    );
  }

  /// `This folder already exists`
  String get folder_exists {
    return Intl.message(
      'This folder already exists',
      name: 'folder_exists',
      desc: '',
      args: [],
    );
  }

  /// `This link already exists`
  String get link_exists {
    return Intl.message(
      'This link already exists',
      name: 'link_exists',
      desc: '',
      args: [],
    );
  }

  /// `Link Manager`
  String get home_page_title {
    return Intl.message(
      'Link Manager',
      name: 'home_page_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
