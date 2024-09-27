import 'package:flutter/widgets.dart';

class AppValidator {
  final Set<AppValidatorType> settings;
  final BuildContext context;
  Map<AppValidatorType, String? Function(String?)> _sourse;

  AppValidator(
    this.context, {
    required this.settings,
  }) : _sourse = {} {
    _sourse = {
      AppValidatorType.required: _required,
      AppValidatorType.link: _isLink,
      AppValidatorType.mail: _isLinkToMail,
      AppValidatorType.phone: _isLinkToPhone,
    };
  }

  String? _required(
    String? value,
  ) {
    return value != null && value.isNotEmpty ? null : 'Это поле обязятельное';
  }

  String? _isLink(
    String? value,
  ) {
    final linkExp = RegExp(r'^https?://');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : 'Неверный формат ссылки';
  }

  String? _isLinkToPhone(
    String? value,
  ) {
    final linkExp = RegExp(r'^\+?\d+$');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : 'Неверный формат номера';
  }

  String? _isLinkToMail(
    String? value,
  ) {
    final linkExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : 'Неверный формат почты';
  }

  String? validate(
    String? value,
  ) {
    String? result;

    for (var type in settings) {
      final func = _sourse[type];
      if (func == null) {
        continue;
      }

      result = func(value);

      if (result != null) {
        return result;
      }
    }

    return null;
  }
}

enum AppValidatorType {
  required,
  link,
  phone,
  mail,
}
