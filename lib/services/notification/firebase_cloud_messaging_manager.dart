import 'package:blueberry_flutter_template/utils/FlutterSecureStorage.dart';
import 'package:blueberry_flutter_template/utils/StorageKeys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'local_notification_manager.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class FirebaseCloudMessagingManager {

  static Future<void> initialize({
    Function(String)? onTokenRefresh,
  }) async {
    if(kIsWeb) return;

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final storage = PreferenceStorage();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    storage.write(StorageKeys.fcmToken, fcmToken);

    FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefresh);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await LocalNotificationManager.initialize();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) return;

      LocalNotificationManager.showNotification({
        'title': message.notification!.title,
        'body': message.notification!.body,
      });
    });
  }

  static Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
