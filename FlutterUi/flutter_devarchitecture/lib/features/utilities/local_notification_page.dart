import 'package:flutter/material.dart';
import '/core/di/core_initializer.dart';

import '../../core/utilities/local_notification/i_notification_service.dart';
import '../layouts/base_scaffold.dart';

class LocalNotificationPage extends StatefulWidget {
  @override
  _LocalNotificationPageState createState() => _LocalNotificationPageState();
}

class _LocalNotificationPageState extends State<LocalNotificationPage> {
  late INotificationService _notificationService;

  @override
  void initState() {
    super.initState();
    _notificationService = CoreInitializer().coreContainer.notificationService;
  }

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
      context,
      _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _notificationService.showNotification(
              "Bu bir bildirimdir.",
              "Bildirim Başlığı",
              context,
            ),
            child: Text('Bildirim Gönder'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _notificationService.showNotificationWithSound(
              "Bu bildirim ses içeriyor.",
              "Sesli Bildirim",
              context,
            ),
            child: Text('Sesli Bildirim Gönder'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
