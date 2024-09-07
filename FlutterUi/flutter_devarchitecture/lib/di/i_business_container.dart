import 'package:flutter_devarchitecture/features/admin_panel/languages/services/i_language_service.dart';
import 'package:flutter_devarchitecture/features/admin_panel/logs/services/i_service.dart';
import 'package:flutter_devarchitecture/features/admin_panel/operation_claims/services/i_operation_claim_service.dart';
import 'package:flutter_devarchitecture/features/admin_panel/translates/services/i_translate_service.dart';

import '../features/admin_panel/user-group/services/i_user_group_service.dart';
import '/features/admin_panel/user-claims/services/i_user_claim_service.dart';
import '/features/admin_panel/users/services/i_user_service.dart';

import '../features/auth/services/abstract/i_auth_service.dart';

abstract class IBusinessContainer {
  late IAuthService authService;

  late IUserService userService;

  late IUserClaimService userClaimService;

  late IUserGroupService userGroupService;

  late ILogService logService;

  late ITranslateService translateService;

  late ILanguageService languageService;

  late IOperationClaimService operationClaimService;

  void setup();
  void checkIfUnRegistered<T extends Object>(Function register);
}
