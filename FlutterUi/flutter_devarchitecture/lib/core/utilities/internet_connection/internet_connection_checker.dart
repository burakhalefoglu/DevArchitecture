import 'dart:async';
import 'package:flutter_devarchitecture/core/utilities/internet_connection/i_internet_connection.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../screen_message/i_screen_message.dart';

class InternetConnectionWithChecker implements IInternetConnection {
  late StreamSubscription<InternetConnectionStatus> _listener;

  static final InternetConnectionWithChecker _singleton =
      InternetConnectionWithChecker._internal();

  factory InternetConnectionWithChecker() {
    return _singleton;
  }

  InternetConnectionWithChecker._internal();

  @override
  Future<bool> isConnected() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  Future<void> listenConnection(IScreenMessage _screenMessage) async {
    _listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          _screenMessage.getInfoMessage("İnternet Bağlantısı kuruldu!");
          break;
        case InternetConnectionStatus.disconnected:
          _screenMessage.getWarningMessage("İnternet Bağlantısı Kapalı!");

          break;
      }
    });
  }

  @override
  Future<void> stopListening() async {
    _listener.cancel();
  }
}
