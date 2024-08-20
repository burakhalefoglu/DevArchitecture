import '../screen_message/i_screen_message.dart';

abstract class IInternetConnection {
  Future<bool> isConnected();
  Future<void> listenConnection(IScreenMessage _screenMessage);
  Future<void> stopListening();
}
