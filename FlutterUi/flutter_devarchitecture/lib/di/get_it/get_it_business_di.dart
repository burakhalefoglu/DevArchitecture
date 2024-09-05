import 'package:flutter_devarchitecture/features/admin_panel/users/services/i_user_service.dart';
import 'package:get_it/get_it.dart';
import '../../../core/configs/app_config.dart';
import '../../features/admin_panel/users/services/api_user_service.dart';
import '../../features/admin_panel/users/services/in_memory_user_service.dart';
import '../../features/public/auth/services/abstract/i_auth_service.dart';
import '../../features/public/auth/services/concrete/api_auth_service.dart';
import '../../features/public/auth/services/concrete/in_memory_auth_service.dart';
import '../i_business_container.dart';

class GetItBusinessContainer implements IBusinessContainer {
  late GetIt _getIt;
  void _init() {
    _getIt = GetIt.instance;
    setup();
  }

  GetItBusinessContainer() {
    _init();
  }

  @override
  late IAuthService authService;

  @override
  late IUserService userService;

  @override
  void setup() {
    //*? Services Binding For DEVELOPMENT
    if (appConfig.name == 'dev' || appConfig.name == '') {
      checkIfUnRegistered<IAuthService>((() {
        authService =
            _getIt.registerSingleton<IAuthService>(InMemoryAuthService());
      }));

      checkIfUnRegistered<IUserService>((() {
        userService =
            _getIt.registerSingleton<IUserService>(InMemoryUserService());
      }));
    }

    //*? Services Binding For STAGING
    if (appConfig.name == 'staging') {
      checkIfUnRegistered<IAuthService>((() {
        authService = _getIt
            .registerSingleton<IAuthService>(ApiAuthService(method: "/Auth"));
      }));

      checkIfUnRegistered<IUserService>((() {
        userService = _getIt
            .registerSingleton<IUserService>(ApiUserService(method: "/Users"));
      }));
    }

    //*? Services Binding For PRODUCTION
    if (appConfig.name == 'prod') {
      checkIfUnRegistered<IAuthService>((() {
        authService = _getIt
            .registerSingleton<IAuthService>(ApiAuthService(method: "/Auth"));
      }));

      checkIfUnRegistered<IUserService>((() {
        userService = _getIt
            .registerSingleton<IUserService>(ApiUserService(method: "/Users"));
      }));
    }
  }

  @override
  void checkIfUnRegistered<T extends Object>(Function register) {
    if (!_getIt.isRegistered<T>()) {
      register.call();
    }
  }
}
