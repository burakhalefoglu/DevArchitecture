import '../screen_message.dart';

abstract class IBatteryState {
  Future<int> getBatteryLevel();

  Future<bool> isInBatterySaveMode();

  Future<bool> isBatteryCharging();

  Future<void> listenBatteryState(IScreenMessage screenMessage);

  Future<void> stopListeningBatteryState();
}