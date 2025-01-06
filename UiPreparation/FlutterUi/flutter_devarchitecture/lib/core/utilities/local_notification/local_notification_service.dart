import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

import 'i_notification_service.dart';

class LocalNotificationService implements INotificationService {
  LocalNotificationService();

  void _showNotificationWidget(
      BuildContext context, String message, String title,
      {bool playSound = false, bool enableVibration = false}) {
    InAppNotification.show(
      context: context,
      child: NotificationCard(
        title: title,
        message: message,
        playSound: playSound,
        enableVibration: enableVibration,
      ),
      duration: Duration(seconds: 5),
    );
  }

  @override
  void showNotification(BuildContext context, String message, String title) {
    _showNotificationWidget(context, message, title);
  }

  @override
  void showNotificationWithSound(
      BuildContext context, String message, String title) {
    _showNotificationWidget(context, message, title, playSound: true);
  }

  @override
  void showNotificationWithVibration(
      BuildContext context, String message, String title) {
    _showNotificationWidget(context, message, title, enableVibration: true);
  }

  @override
  void showNotificationWithSoundAndVibration(
      BuildContext context, String message, String title) {
    _showNotificationWidget(context, message, title,
        playSound: true, enableVibration: true);
  }

  @override
  void schedulePeriodicNotification(
      BuildContext context, String message, String title, Duration interval) {
    Future.delayed(interval, () {
      _showNotificationWidget(context, message, title);
      schedulePeriodicNotification(context, message, title, interval);
    });
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final bool playSound;
  final bool enableVibration;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    this.playSound = false,
    this.enableVibration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ses ve titreşim özelliklerini burada uygulayabilirsiniz
    if (playSound) {
      // Özel ses çalma mantığını buraya ekleyin
    }
    if (enableVibration) {
      // Titreşim mantığını buraya ekleyin
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
