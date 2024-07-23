import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'i_notification_service.dart';

class LocalNotificationService implements INotificationService {
  static final LocalNotificationService _singleton =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _singleton;
  }
  LocalNotificationService._internal();

  LocalNotificationService.init() {
    _initializeNotifications();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // iOS için bildirimlere tıklama işlemini ele alın
  }

  void _onSelectNotification(NotificationResponse notificationResponse) async {
    // Bildirime tıklama işlemini burada ele alın
    if (notificationResponse.payload != null) {
      print('Bildirim payload: ${notificationResponse.payload}');
      // Burada istenen işlemi gerçekleştirin, örneğin, belirli bir sayfaya yönlendirin
    }
  }

  @override
  void showNotification(String message, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: false,
      enableVibration: false,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(presentSound: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
      linux: LinuxNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  @override
  void showNotificationWithSound(String message, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: true,
      enableVibration: false,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(presentSound: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
      linux: LinuxNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      1,
      title,
      message,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  @override
  void showNotificationWithVibration(String message, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: false,
      enableVibration: true,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(presentSound: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
      linux: LinuxNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      2,
      title,
      message,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  @override
  void showNotificationWithSoundAndVibration(
      String message, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(presentSound: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
      linux: LinuxNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      3,
      title,
      message,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  @override
  void schedulePeriodicNotification(
      String message, String title, Duration interval) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(presentSound: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
      linux: LinuxNotificationDetails(),
    );

    // Periodically show the notification
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      4,
      title,
      message,
      _convertDurationToRepeatInterval(interval),
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  RepeatInterval _convertDurationToRepeatInterval(Duration duration) {
    if (duration.inMinutes <= 60) {
      return RepeatInterval.everyMinute;
    } else if (duration.inHours <= 24) {
      return RepeatInterval.hourly;
    } else if (duration.inDays <= 7) {
      return RepeatInterval.daily;
    } else {
      return RepeatInterval.weekly;
    }
  }
}
