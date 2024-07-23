import '../di/core_initializer.dart';

mixin BatteryStateMixin {
  Future<void> listenBatteryState() async {
    var _batteryState = CoreInitializer().coreContainer.batteryState;
    var _screenMessage = CoreInitializer().coreContainer.screenMessage;
    await _batteryState.listenBatteryState(_screenMessage);
  }

  Future<void> stopCheckingConnection() async {
    var _batteryState = CoreInitializer().coreContainer.internetConnection;
    await _batteryState.stopListening();
  }
}
