import 'package:flutter/widgets.dart';
import 'package:link_manager/generated/l10n.dart';

class AppValidator {
  final Set<AppValidatorType> settings;
  final BuildContext context;
  Map<AppValidatorType, String? Function(String?)> _source;

  AppValidator(
    this.context, {
    required this.settings,
  }) : _source = {} {
    _source = {
      AppValidatorType.required: _required,
      AppValidatorType.link: _isLink,
      AppValidatorType.mail: _isLinkToMail,
      AppValidatorType.phone: _isLinkToPhone,
    };
  }

  String? _required(
    String? value,
  ) {
    return value != null && value.isNotEmpty
        ? null
        : S.of(context).validate_required;
  }

  String? _isLink(
    String? value,
  ) {
    final linkExp = RegExp(r'^https?://');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : S.of(context).validate_link;
  }

  String? _isLinkToPhone(
    String? value,
  ) {
    final linkExp = RegExp(r'^\+?[0-9]{7,15}$');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : S.of(context).validate_phone;
  }

  String? _isLinkToMail(
    String? value,
  ) {
    final linkExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    final hasMatch = linkExp.hasMatch(value ?? '');
    return hasMatch ? null : S.of(context).validate_email;
  }

  String? validate(
    String? value,
  ) {
    String? result;

    for (var type in settings) {
      final func = _source[type];
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
