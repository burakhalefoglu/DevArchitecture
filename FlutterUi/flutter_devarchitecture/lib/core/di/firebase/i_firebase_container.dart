import '../../utilities/firebase/messaging/i_push_notification.dart';

abstract class IFirebaseContainer {
  // firebase
  late IPushNotificationService pushNotificationService;
  // get it
  setUp();
  void checkIfUnRegistered<T extends Object>(Function register);
}
