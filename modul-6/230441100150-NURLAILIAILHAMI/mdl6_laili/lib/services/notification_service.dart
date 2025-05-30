import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notifications.initialize(settings);
  }

  void showNotification({required String title, required String body}) {
    const details = NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName'),
    );
    _notifications.show(0, title, body, details);
  }
}
