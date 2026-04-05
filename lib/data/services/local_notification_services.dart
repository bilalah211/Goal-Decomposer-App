import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    //Initialize Timezones
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      final bool? canScheduleExactAlarms = await androidPlugin
          .canScheduleExactNotifications();
      if (canScheduleExactAlarms == false) {
        await androidPlugin.requestExactAlarmsPermission();
      }
    }
  }

  // Schedule a notification for the deadline
  static Future<void> scheduleDeadlineNotification({
    required int id,
    required String title,
    required DateTime deadline,
  }) async {
    final scheduleDate = deadline.subtract(const Duration(seconds: 30));

    if (scheduleDate.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      'Deadline Approaching!',
      'Your goal "$title" is due tomorrow!',
      tz.TZDateTime.from(scheduleDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'deadline_channel', // ID
          'Goal Deadlines', // Name
          channelDescription: 'Notifications for goal deadlines',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',

          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
