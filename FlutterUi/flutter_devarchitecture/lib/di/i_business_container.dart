import 'package:flutter_devarchitecture/features/admin_panel/users/services/i_user_service.dart';

import '../features/public/auth/services/abstract/i_auth_service.dart';

abstract class IBusinessContainer {
  late IAuthService authService;

  late IUserService userService;

  void setup();
  void checkIfUnRegistered<T extends Object>(Function register);
}
