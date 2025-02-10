import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:url_launcher/url_launcher.dart';

const Widget loadWidget = Center(child: CircularProgressIndicator.adaptive());

const String kSupportUrl = 'https://www.donationalerts.com/r/vazgen2k4';

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

  final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  final urlRegex = RegExp(r'^(http|https)://[^\s]+$');
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

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

  await launchUrl(Uri.parse(newLink));
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

const String kMainUsersTopic = 'all_users';
const String kMainAndroidChannelId = 'main_channel';
const String kMainAndroidNotificationIcon = '@mipmap/ic_launcher';

const kMainAndroidChannel = AndroidNotificationChannel(
  kMainAndroidChannelId,
  'Main Channel',
  description: 'Основной канал уведомлений для Android',
  importance: Importance.max,
);
