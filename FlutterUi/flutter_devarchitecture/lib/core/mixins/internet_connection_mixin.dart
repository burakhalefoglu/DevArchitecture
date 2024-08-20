import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

mixin InternetConnectionCheckerMixin<T extends StatefulWidget> on State<T> {
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
