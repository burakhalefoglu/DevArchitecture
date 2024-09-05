import '../features/admin_panel/user-group/services/i_user_group_service.dart';
import '/features/admin_panel/user-claims/services/i_user_claim_service.dart';
import '/features/admin_panel/users/services/i_user_service.dart';

import '../features/auth/services/abstract/i_auth_service.dart';

abstract class IBusinessContainer {
  late IAuthService authService;

  late IUserService userService;

  late IUserClaimService userClaimService;

  late IUserGroupService userGroupService;

  void setup();
  void checkIfUnRegistered<T extends Object>(Function register);
}
