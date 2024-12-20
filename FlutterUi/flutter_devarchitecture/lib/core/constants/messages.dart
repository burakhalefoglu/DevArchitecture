import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/helpers/translate_provider_extension.dart';

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
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
