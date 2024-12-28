import 'dart:async';
import 'package:flutter/material.dart';
import '/core/utilities/internet_connection/i_internet_connection.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../screen_message/i_screen_message.dart';

class InternetConnectionWithChecker implements IInternetConnection {
  late final StreamSubscription<InternetStatus> _subscription;
  late final AppLifecycleListener _listener;

  @override
  Future<bool> isConnected() async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    return isConnected;
  }

  @override
  Future<void> listenConnection(IScreenMessage _screenMessage) async {
    _subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          break;
      }
    });
    _listener = AppLifecycleListener(
      onResume: _subscription.resume,
      onHide: _subscription.pause,
      onPause: _subscription.pause,
    );
  }

  @override
  Future<void> stopListening() async {
    _subscription.cancel();
    _listener.dispose();
  }
}
