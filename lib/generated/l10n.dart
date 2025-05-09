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

  /// `English`
  String get current_lang {
    return Intl.message(
      'English',
      name: 'current_lang',
      desc: '',
      args: [],
    );
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

  /// `CTU - FEL`
  String get ctu_section_title {
    return Intl.message(
      'CTU - FEL',
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

  /// `Thank you for your support ❤️`
  String get support_response_msg {
    return Intl.message(
      'Thank you for your support ❤️',
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
  String get field_label_name {
    return Intl.message(
      'Name',
      name: 'field_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get field_label_link {
    return Intl.message(
      'Link',
      name: 'field_label_link',
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
  String get delete {
    return Intl.message(
      'Deletion',
      name: 'delete',
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

  /// `Folder "$" has been successfully created`
  String get folder_create {
    return Intl.message(
      'Folder "\$" has been successfully created',
      name: 'folder_create',
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

  /// `Calculator`
  String get calc_title {
    return Intl.message(
      'Calculator',
      name: 'calc_title',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get calc_credits {
    return Intl.message(
      'Credits',
      name: 'calc_credits',
      desc: '',
      args: [],
    );
  }

  /// `Weighted credits`
  String get calc_weighted {
    return Intl.message(
      'Weighted credits',
      name: 'calc_weighted',
      desc: '',
      args: [],
    );
  }

  /// `Weighted average`
  String get calc_weighted_average {
    return Intl.message(
      'Weighted average',
      name: 'calc_weighted_average',
      desc: '',
      args: [],
    );
  }

  /// `GPA`
  String get calc_gpa {
    return Intl.message(
      'GPA',
      name: 'calc_gpa',
      desc: '',
      args: [],
    );
  }

  /// `Add grade`
  String get add_grade {
    return Intl.message(
      'Add grade',
      name: 'add_grade',
      desc: '',
      args: [],
    );
  }

  /// `You have no grades yet...`
  String get have_no_grades {
    return Intl.message(
      'You have no grades yet...',
      name: 'have_no_grades',
      desc: '',
      args: [],
    );
  }

  /// `Home page`
  String get settings_home_page_section {
    return Intl.message(
      'Home page',
      name: 'settings_home_page_section',
      desc: '',
      args: [],
    );
  }

  /// `Show KOS button`
  String get show_kos_button {
    return Intl.message(
      'Show KOS button',
      name: 'show_kos_button',
      desc: '',
      args: [],
    );
  }

  /// `Show CTU links`
  String get show_ctu_links {
    return Intl.message(
      'Show CTU links',
      name: 'show_ctu_links',
      desc: '',
      args: [],
    );
  }

  /// `Wrap CTU links`
  String get wrap_ctu_links {
    return Intl.message(
      'Wrap CTU links',
      name: 'wrap_ctu_links',
      desc: '',
      args: [],
    );
  }

  /// `Search folders`
  String get search_folders {
    return Intl.message(
      'Search folders',
      name: 'search_folders',
      desc: '',
      args: [],
    );
  }

  /// `Show NTK people`
  String get show_ntk_people {
    return Intl.message(
      'Show NTK people',
      name: 'show_ntk_people',
      desc: '',
      args: [],
    );
  }

  /// `No results`
  String get no_results {
    return Intl.message(
      'No results',
      name: 'no_results',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Remove selected folders`
  String get remove_selected_folders {
    return Intl.message(
      'Remove selected folders',
      name: 'remove_selected_folders',
      desc: '',
      args: [],
    );
  }

  /// `Error with NTK, try again later`
  String get errors_ntk_api {
    return Intl.message(
      'Error with NTK, try again later',
      name: 'errors_ntk_api',
      desc: '',
      args: [],
    );
  }

  /// `NTK people`
  String get ntk_people {
    return Intl.message(
      'NTK people',
      name: 'ntk_people',
      desc: '',
      args: [],
    );
  }

  /// `NTK`
  String get ntk_title {
    return Intl.message(
      'NTK',
      name: 'ntk_title',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get version_section_title {
    return Intl.message(
      'About App',
      name: 'version_section_title',
      desc: '',
      args: [],
    );
  }

  /// `Current version: {version}`
  String version_is(String version) {
    return Intl.message(
      'Current version: $version',
      name: 'version_is',
      desc: '',
      args: [version],
    );
  }

  /// `Current build: {build}`
  String build_is(String build) {
    return Intl.message(
      'Current build: $build',
      name: 'build_is',
      desc: '',
      args: [build],
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
