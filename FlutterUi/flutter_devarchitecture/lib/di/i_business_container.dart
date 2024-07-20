import '../features/public/auth/services/abstract/i_auth_service.dart';

abstract class IBusinessContainer {
  late IAuthService authService;

  void setup();
  void checkIfUnRegistered<T extends Object>(Function register);
}
