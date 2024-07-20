abstract class INotificationService {
  void showNotification(String message, String title);
  void showNotificationWithSound(String message, String title);
  void showNotificationWithVibration(String message, String title);
  void showNotificationWithSoundAndVibration(String message, String title);
  void schedulePeriodicNotification(
      String message, String title, Duration interval);
}
