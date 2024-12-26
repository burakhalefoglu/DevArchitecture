import 'package:flutter/material.dart';
import '/core/helpers/translate_provider_extension.dart';

class Messages {
  static late BuildContext _context;

  // Info Messages
  static late String formValidationErrorMessage;
  static late String customerDefaultHttpMessage;
  static late String customerDefaultCalculateMessage;
  static late String customerSaveInfoMessage;
  static late String customerInternetConnectionSuccessMessage;

  // Warning Messages
  static late String customerDefaultWarningMessage;

  // Error Messages
  static late String customerInternetConnectionErrorMessage;
  static late String customerDefaultErrorMessage;
  static late String companyNameInputFieldWidgetEmptyErrorMessage;
  static late String pageNotFound;

  // Success Messages
  static late String customerSuccessHttpMessage;
  static late String customerSuccessSaveMessage;
  static late String customerSuccessCalculateMessage;
  static late String customerAddSuccessMessage;
  static late String checkSuccessMessage;
  static late String customerDefaultSuccessMessage;
  static late String downloadSuccessMessage;

  static late String comingSoon;
  static late String selectOutputFileMessage;
  static late String cantBeEmpty;
  static late String invalidEmail;
  static late String minCharacter;
  static late String maxCharacter;
  static late String invalidPhone;
  static late String invalidPassword;
  static late String minimum;
  static late String maximum;
  static late String invalidNumber;
  static late String invalid;
  static late String invalidDate;
  static late String dateCantBeEmpty;
  static late String groupPermissionUpdate;
  static late String groupUpdate;
  static late String passwordChange;
  static late String permissionChange;
  static late String groupChange;
  static late String editMessage;
  static late String deleteMessage;
  static late String downloadMessage;
  static late String addMessage;
  static late String detailedInformationMessage;

  static late String groupInfoHover;
  static late String atLeastOneSelection;
  static late String languageInfoHover;
  static late String logInfoHover;
  static late String operationClaimInfoHover;
  static late String translateInfoHover;
  static late String passwordsDoNotMatch;
  static late String userInfoHover;

  static void init(BuildContext context) {
    _context = context;

    pageNotFound = _translate("PageNotFound");
    formValidationErrorMessage = _translate("FormValidationErrorMessage");
    customerDefaultHttpMessage = _translate("CustomerDefaultHttpMessage");
    customerDefaultCalculateMessage =
        _translate("CustomerDefaultCalculateMessage");
    customerSaveInfoMessage = _translate("CustomerSaveInfoMessage");
    customerInternetConnectionSuccessMessage =
        _translate("CustomerInternetConnectionSuccessMessage");
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
    selectOutputFileMessage = _translate("SelectOutputFileMessage");
    comingSoon = _translate("ComingSoon");
    downloadSuccessMessage = _translate("DownloadSuccessMessage");
    cantBeEmpty = _translate("CantBeEmpty");
    invalidEmail = _translate("InvalidEmail");
    minCharacter = _translate("MinCharacter");
    maxCharacter = _translate("MaxCharacter");
    invalidPhone = _translate("invalidPhone");
    invalidPassword = _translate("InvalidPassword");
    minimum = _translate("Minimum");
    maximum = _translate("Maximum");
    invalidNumber = _translate("InvalidNumber");
    invalid = _translate("Invalid");
    invalidDate = _translate("InvalidDate");
    dateCantBeEmpty = _translate("DateCantBeEmpty");

    groupPermissionUpdate = _translate("GroupPermissionUpdate");
    groupUpdate = _translate("GroupUpdate");
    passwordChange = _translate("PasswordChange");
    permissionChange = _translate("PermissionChange");
    groupChange = _translate("GroupChange");
    editMessage = _translate("EditMessage");
    deleteMessage = _translate("DeleteMessage");
    downloadMessage = _translate("DownloadMessage");
    addMessage = _translate("AddMessage");
    detailedInformationMessage = _translate("DetailedInformationMessage");
    groupInfoHover = _translate("GroupInfoHover");
    atLeastOneSelection = _translate("AtLeastOneSelection");
    languageInfoHover = _translate("LanguageInfoHover");
    logInfoHover = _translate("LogInfoHover");
    operationClaimInfoHover = _translate("OperationClaimInfoHover");
    translateInfoHover = _translate("TranslateInfoHover");
    passwordsDoNotMatch = _translate("PasswordsDoNotMatch");
    userInfoHover = _translate("UserInfoHover");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
