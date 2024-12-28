import 'package:flutter/widgets.dart';
import 'package:platform_local_notifications/platform_local_notifications.dart';
import '../../constants/temp/screen_element_constants.dart';
import 'i_notification_service.dart';

class LocalNotificationService implements INotificationService {
  LocalNotificationService() {
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    await PlatformNotifier.I.init(appName: ScreenElementConstants.appName);
  }

  @override
  void showNotification(
      String message, String title, BuildContext context) async {
    await PlatformNotifier.I.showPluginNotification(
        ShowPluginNotificationModel(
          id: DateTime.now().microsecond,
          title: title,
          body: message,
        ),
        context);
  }

  @override
  void showNotificationWithSound(
      String message, String title, BuildContext context) async {
    await PlatformNotifier.I.showPluginNotification(
        ShowPluginNotificationModel(
            id: DateTime.now().microsecond,
            title: title,
            body: message,
            linux: LinuxNotificationDetails(suppressSound: false),
            iosDetails: DarwinNotificationDetails(
                presentAlert: true, presentBanner: true, presentSound: true),
            macOsDetails: DarwinNotificationDetails(
              presentAlert: true,
              presentBanner: true,
              presentSound: true,
            ),
            androidNotificationDetails: AndroidNotificationDetails(
              "channel1",
              "Channel 1",
              playSound: true,
            )),
        context);
  }

  @override
  void requestPermission() async {
    await PlatformNotifier.I.requestPermissions();
  }
}
