import 'i_notification_service.dart';

class LocalNotificationService implements INotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void showNotification(String message, String title) {
    // TODO: implement showNotification
  }

  @override
  void showNotificationWithSound(String message, String title) {
    // TODO: implement showNotificationWithSound
  }

  @override
  void showNotificationWithSoundAndVibration(String message, String title) {
    // TODO: implement showNotificationWithSoundAndVibration
  }

  @override
  void showNotificationWithVibration(String message, String title) {
    // TODO: implement showNotificationWithVibration
  }
}
