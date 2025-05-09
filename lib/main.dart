import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/services/notification_service.dart';
import 'package:link_manager/ui/app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.android) {
    // Initialize the notification service
    await NotificationService.instance.init();
  }

  runApp(const App());
}
