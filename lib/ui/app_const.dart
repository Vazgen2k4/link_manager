import 'dart:math';
import 'package:flutter/material.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:url_launcher/url_launcher.dart';

Future<T?> goRoute<T extends Object?>(
  BuildContext context,
  String route, {
  bool withRemoveUntil = false,
}) async {
  if (withRemoveUntil) {
    return await Navigator.of(context).pushNamedAndRemoveUntil(
      route,
      (route) => false,
    );
  }

  return await Navigator.of(context).pushNamed(route);
}

const Widget loadWidget = Center(child: CircularProgressIndicator.adaptive());

String getRandomWord() {
  final List<String> words = [
    'яблоко',
    'кот',
    'дом',
    'автомобиль',
    'книга',
    'солнце',
    'море',
    'гора',
    'цветок',
    'шоколад',
  ];

  final Random random = Random();
  final int randomIndex = random.nextInt(words.length);

  return words[randomIndex];
}

IconData getIconByLinkType(AppLinkType? type) => switch (type) {
      AppLinkType.email => Icons.email,
      AppLinkType.phone => Icons.phone,
      AppLinkType.link => Icons.link,
      AppLinkType.none => Icons.folder_rounded,
      _ => Icons.folder_rounded,
    };

AppLinkType getLinkType(String? link) {
  if (link == null || link.isEmpty) {
    return AppLinkType.none;
  }

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  final urlRegex = RegExp(r'^(http|https)://[^\s]+$');

  if (emailRegex.hasMatch(link)) {
    return AppLinkType.email;
  }

  if (phoneRegex.hasMatch(link)) {
    return AppLinkType.phone;
  }

  if (urlRegex.hasMatch(link)) {
    return AppLinkType.link;
  }

  return AppLinkType.none;
}

void launchUrlByLink(String? link) async {
  if (link == null || link.isEmpty) {
    return;
  }

  final linkType = getLinkType(link);
  final newLink = getLinkValueByType(type: linkType, link: link);
  
  AppLogger.logInfo('Парсинг ссылки: $newLink');
  
  Uri url = Uri.parse(newLink);
  await launchUrl(url);
}

String getLinkValueByType({
  required AppLinkType type,
  required String link,
}) =>
    switch (type) {
      AppLinkType.phone => 'tel:$link',
      AppLinkType.email => 'mailto:$link',
      _ => link,
    };
