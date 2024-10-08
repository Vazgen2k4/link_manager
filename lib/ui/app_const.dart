import 'dart:math';
import 'package:flutter/material.dart';
import 'package:link_manager/logic/models/link/app_link.dart';

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

IconData getIconDataByAppLink(AppLink link) => switch (link.type) {
      AppLinkType.email => Icons.email,
      AppLinkType.phone => Icons.phone,
      AppLinkType.link => Icons.link,
      _ => Icons.link,
    };
