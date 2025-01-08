import 'package:flutter/material.dart';
import '/core/helpers/translate_provider_extension.dart';

class Messages1 {
  static late BuildContext _context;

  // Info Messages

  // Warning Messages
  static late String customerDefaultWarningMessage;

  // Error Messages
  static late String customerInternetConnectionErrorMessage;
  static late String customerDefaultErrorMessage;
  static late String companyNameInputFieldWidgetEmptyErrorMessage;

  // Success Messages
  static late String customerSuccessHttpMessage;
  static late String customerSuccessSaveMessage;
  static late String customerSuccessCalculateMessage;
  static late String customerAddSuccessMessage;
  static late String checkSuccessMessage;
  static late String customerDefaultSuccessMessage;

  static late String groupUpdate;
  static late String passwordChange;
  static late String permissionChange;
  static late String groupChange;

  static late String operationClaimInfoHover;
  static late String translateInfoHover;
  static late String passwordsDoNotMatch;
  static late String userInfoHover;

  static void init(BuildContext context) {
    _context = context;

    customerDefaultWarningMessage = _translate("CustomerDefaultWarningMessage");
    customerInternetConnectionErrorMessage =
        _translate("CustomerInternetConnectionErrorMessage");
    customerDefaultErrorMessage = _translate("CustomerDefaultErrorMessage");
    companyNameInputFieldWidgetEmptyErrorMessage =
        _translate("CompanyNameInputFieldWidgetEmptyErrorMessage");
    customerSuccessHttpMessage = _translate("CustomerSuccessHttpMessage");
    customerSuccessSaveMessage = _translate("CustomerSuccessSaveMessage");
    customerSuccessCalculateMessage =
        _translate("CustomerSuccessCalculateMessage");
    customerAddSuccessMessage = _translate("CustomerAddSuccessMessage");
    checkSuccessMessage = _translate("CheckSuccessMessage");
    customerDefaultSuccessMessage = _translate("CustomerDefaultSuccessMessage");

    groupUpdate = _translate("GroupUpdate");
    passwordChange = _translate("PasswordChange");
    permissionChange = _translate("PermissionChange");
    groupChange = _translate("GroupChange");

    operationClaimInfoHover = _translate("OperationClaimInfoHover");
    translateInfoHover = _translate("TranslateInfoHover");
    passwordsDoNotMatch = _translate("PasswordsDoNotMatch");
    userInfoHover = _translate("UserInfoHover");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
