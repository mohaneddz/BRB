import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Persistent "BRB is watching" notification shown while armed (Settings >
/// Floating Notifications). A plain heads-down notification, not a
/// SYSTEM_ALERT_WINDOW overlay bubble.
class NotificationService {
  static const _armedNotificationId = 1;
  static const _channelId = 'brb_armed_channel';

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings: settings);
  }

  Future<void> showArmed(String modeLabel) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      'Armed Status',
      channelDescription: 'Shows while BRB is armed and watching.',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      autoCancel: false,
      showWhen: false,
    );
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(
      id: _armedNotificationId,
      title: 'BRB is watching',
      body: '$modeLabel mode - tap to open',
      notificationDetails: details,
    );
  }

  Future<void> cancelArmed() async {
    await _plugin.cancel(id: _armedNotificationId);
  }
}
