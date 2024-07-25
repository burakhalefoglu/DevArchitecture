import 'package:flutter_devarchitecture/core/di/firebase/i_firebase_container.dart';
import 'package:get_it/get_it.dart';

import '../../../utilities/firebase/messaging/firebase_notification_service.dart';
import '../../../utilities/firebase/messaging/i_push_notification.dart';

class GetItFirebaseContainer implements IFirebaseContainer {
  late GetIt _getIt;
  void init() {
    _getIt = GetIt.instance;
    setUp();
  }

  GetItFirebaseContainer() {
    init();
  }

  // Utilities -> firebase
  @override
  late IPushNotificationService pushNotificationService;

  @override
  setUp() {
    //! firebase

    // firebase -> push notification
    checkIfUnRegistered<IPushNotificationService>((() {
      pushNotificationService =
          _getIt.registerSingleton<IPushNotificationService>(
              FirebaseNotificationService());
    }));
  }

  @override
  void checkIfUnRegistered<T extends Object>(Function register) {
    if (!_getIt.isRegistered<T>()) {
      register.call();
    }
  }
}
