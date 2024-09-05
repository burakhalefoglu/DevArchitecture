import 'package:flutter_devarchitecture/features/admin_panel/user-claims/services/i_user_claim_service.dart';
import 'package:flutter_devarchitecture/features/admin_panel/users/services/i_user_service.dart';
import 'package:get_it/get_it.dart';
import '../../../core/configs/app_config.dart';
import '../../features/admin_panel/user-group/services/api_user_group_service.dart';
import '../../features/admin_panel/user-group/services/i_user_group_service.dart';
import '../../features/admin_panel/user-group/services/in_memory_user_group_Service.dart';
import '../../features/admin_panel/user-claims/services/api_user_claim.service.dart';
import '../../features/admin_panel/user-claims/services/in_memory_user_claim.dart';
import '../../features/admin_panel/users/services/api_user_service.dart';
import '../../features/admin_panel/users/services/in_memory_user_service.dart';
import '../../features/auth/services/abstract/i_auth_service.dart';
import '../../features/auth/services/concrete/api_auth_service.dart';
import '../../features/auth/services/concrete/in_memory_auth_service.dart';
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
  late IUserClaimService userClaimService;

  @override
  late IUserGroupService userGroupService;

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

      checkIfUnRegistered<IUserClaimService>((() {
        userClaimService = _getIt
            .registerSingleton<IUserClaimService>(InMemoryUserClaimService());
      }));

      checkIfUnRegistered<IUserGroupService>((() {
        userGroupService = _getIt
            .registerSingleton<IUserGroupService>(InMemoryUserGroupService());
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

      checkIfUnRegistered<IUserClaimService>((() {
        userClaimService = _getIt.registerSingleton<IUserClaimService>(
            ApiUserClaimService(method: "/user-claims"));
      }));

      checkIfUnRegistered<IUserGroupService>((() {
        userGroupService = _getIt.registerSingleton<IUserGroupService>(
            ApiUserGroupService(method: "/user-groups"));
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

      checkIfUnRegistered<IUserClaimService>((() {
        userClaimService = _getIt.registerSingleton<IUserClaimService>(
            ApiUserClaimService(method: "/user-claims"));
      }));

      checkIfUnRegistered<IUserGroupService>((() {
        userGroupService = _getIt.registerSingleton<IUserGroupService>(
            ApiUserGroupService(method: "/user-groups"));
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
