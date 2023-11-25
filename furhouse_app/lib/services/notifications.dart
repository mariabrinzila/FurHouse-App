import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class Notifications {
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviourSubject = BehaviorSubject();

  Notifications();

  Future<void> initializePlatformNotifications() async {
    const initializeAndroidSettings = AndroidInitializationSettings(
      "ic_pet",
    );

    final initializeiOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializeAndroidSettings,
      iOS: initializeiOSSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviourSubject.add(payload);
    }
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    var payload = notificationResponse.payload;

    if (payload != null && payload.isNotEmpty) {
      behaviourSubject.add(payload);
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    final androidPlatformaChannelSpecifics = AndroidNotificationDetails(
      "channel id",
      "channel name",
      groupKey: "furhouse_app",
      channelDescription: "channel description",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: "ticker",
      color: darkBlueColor,
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      threadIdentifier: "thread1",
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      behaviourSubject.add(details.notificationResponse!.payload!);
    }

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformaChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void cancelAllNotifications() {
    _localNotifications.cancelAll();
  }
}
