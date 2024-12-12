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

  // Success Messages
  static late String customerSuccessHttpMessage;
  static late String customerSuccessSaveMessage;
  static late String customerSuccessCalculateMessage;

  static late String fuelInputErrorMessage;
  static late String fuelSpendErrorMessage;

  static late String customerAddSuccessMessage;
  static late String checkSuccessMessage;

  static void init(BuildContext context) {
    _context = context;

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

    fuelInputErrorMessage = _translate("FuelInputErrorMessage");
    fuelSpendErrorMessage = _translate("FuelSpendErrorMessage");

    customerAddSuccessMessage = _translate("CustomerAddSuccessMessage");
    checkSuccessMessage = _translate("CheckSuccessMessage");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
