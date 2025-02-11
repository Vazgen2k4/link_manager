import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rountiner/core/consts.dart';
import 'package:http/http.dart' as http;
import 'package:link_manager/app_logger.dart';
import 'package:link_manager/ui/app_const.dart';

class NotificationService {
  NotificationService._();

  static NotificationService? _instance;

  static NotificationService get instance {
    _instance ??= NotificationService._();
    return _instance!;
  }

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  bool _isLocaleNotificationsInitialized = false;
  String? _token;
  String? get token => _token;

  NotificationDetails _getNotificationDetails({
    BigPictureStyleInformation? bigPictureStyleInformation,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        kMainAndroidChannel.id,
        kMainAndroidChannel.name,
        channelDescription: kMainAndroidChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        icon: kMainAndroidNotificationIcon,
        styleInformation: bigPictureStyleInformation,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestPermission();
    await _setUpFirebaseHandlers();

    _token = await _messaging.getToken();
    AppLogger.logInfo('Firebase token: $_token');
    
    subscribeToTopics([kMainUsersTopic]);
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("Разрешение на уведомления ОТКЛОНЕНО пользователем.");
    } else {
      log("Разрешение на уведомления: ${settings.authorizationStatus}");
    }
  }

  Future<void> _initLocalNotifications() async {
    if (_isLocaleNotificationsInitialized) {
      return;
    }

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(kMainAndroidChannel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(kMainAndroidNotificationIcon);

    // IOS Initialization Settings

    const initializationSettingsIos = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    await _localNotifications.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    _isLocaleNotificationsInitialized = true;
  }

  Future<void> showFirebaseNotification(RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) {
      log('Уведомление не содержит данных');
      return;
    }

    final androidNotification = message.notification?.android;

    if (androidNotification == null) {
      log('Уведомление не содержит данных для Android');
      return;
    }

    if (notification.title == null || notification.body == null) {
      log('Уведомление не содержит заголовка или тела');
      return;
    }

    final imageUrl = notification.android?.imageUrl;

    BigPictureStyleInformation? bigPictureStyleInformation;
    if (imageUrl != null) {
      try {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final byteArray = response.bodyBytes;
          bigPictureStyleInformation = BigPictureStyleInformation(
            ByteArrayAndroidBitmap(byteArray),
            largeIcon: ByteArrayAndroidBitmap(byteArray),
            contentTitle: notification.title,
            summaryText: notification.body,
          );
        }
      } catch (e) {
        log('Failed to fetch image: $e');
      }
    }

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      _getNotificationDetails(
        bigPictureStyleInformation: bigPictureStyleInformation,
      ),
      payload: message.data.toString(),
    );
  }

  Future<void> _setUpFirebaseHandlers() async {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen(showFirebaseNotification);

    // Open app from background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // open app from terminated state
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) async {
    log("Получено фоновое сообщение: ${message.messageId}");

    if (message.data['type'] == 'chat') {
      // open chat screen
    }
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    await _initLocalNotifications();

    await _localNotifications.show(
      id,
      title,
      body,
      _getNotificationDetails(),
      payload: payload,
    );
  }

  Future<void> subscribeToTopics(List<String> topics) async {
    for (final topic in topics) {
      await _messaging.subscribeToTopic(topic);
    }
  }

  Future<void> unsubscribeFromTopics(List<String> topics) async {
    for (final topic in topics) {
      await _messaging.unsubscribeFromTopic(topic);
    }
  }
}

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final notificationService = NotificationService.instance;

  await notificationService._initLocalNotifications();
  await notificationService.showFirebaseNotification(message);
}
