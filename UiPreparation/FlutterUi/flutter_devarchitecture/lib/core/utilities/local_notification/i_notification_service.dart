import 'package:flutter/widgets.dart';

abstract class INotificationService {
  void showNotification(String message, String title, BuildContext context);
  void showNotificationWithSound(
      String message, String title, BuildContext context);
  void requestPermission();
}
