import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

mixin InternetConnectionCheckerMixin {
  Future<void> listenConnection() async {
    var _internetConnection =
        CoreInitializer().coreContainer.internetConnection;
    var _screenMessage = CoreInitializer().coreContainer.screenMessage;
    await _internetConnection.listenConnection(_screenMessage);
  }

  Future<void> stopCheckingConnection() async {
    var _internetConnection =
        CoreInitializer().coreContainer.internetConnection;
    await _internetConnection.stopListening();
  }
}
