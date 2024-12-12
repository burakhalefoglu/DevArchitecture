import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/helpers/translate_provider_extension.dart';

class ScreenElementConstants {
  static late BuildContext _context;

  static late String loginTitle;
  static late String loginButton;
  static late String registerButton;
  static late String registerTitle;
  static late String usernameHint;
  static late String passwordHint;
  static late String confirmPasswordHint;
  static late String rememberMeHint;
  static late String forgotPasswordHint;
  static late String forgotPasswordTitle;
  static late String sendButton;
  static late String sendAgainButton;
  static late String resendButton;
  static late String resendAgainButton;
  static late String resetButton;
  static late String resetPasswordTitle;
  static late String resetPasswordHint;
  static late String resetPasswordAgainHint;
  static late String resetPasswordButton;
  static late String newInputButton;
  static late String summaryTitle;
  static late String dateFormat;
  static late String timeFormat;
  static late String dateTimeFormat;
  static late String dateHint;
  static late String okButton;
  static late String cancelButton;
  static late String yesButton;
  static late String noButton;
  static late String deleteButton;
  static late String editButton;
  static late String saveButton;
  static late String backButton;
  static late String addButton;
  static late String filterButton;
  static late String clearButton;
  static late String sortButton;
  static late String id;

  static void init(BuildContext context) {
    _context = context;

    loginTitle = _translate("LoginTitle");
    loginButton = _translate("LoginButton");
    registerButton = _translate("RegisterButton");
    registerTitle = _translate("RegisterTitle");
    usernameHint = _translate("UsernameHint");
    passwordHint = _translate("PasswordHint");
    confirmPasswordHint = _translate("ConfirmPasswordHint");
    rememberMeHint = _translate("RememberMeHint");
    forgotPasswordHint = _translate("ForgotPasswordHint");
    forgotPasswordTitle = _translate("ForgotPasswordTitle");
    sendButton = _translate("SendButton");
    sendAgainButton = _translate("SendAgainButton");
    resendButton = _translate("ResendButton");
    resendAgainButton = _translate("ResendAgainButton");
    resetButton = _translate("ResetButton");
    resetPasswordTitle = _translate("ResetPasswordTitle");
    resetPasswordHint = _translate("ResetPasswordHint");
    resetPasswordAgainHint = _translate("ResetPasswordAgainHint");
    resetPasswordButton = _translate("ResetPasswordButton");
    newInputButton = _translate("NewInputButton");
    summaryTitle = _translate("SummaryTitle");
    dateFormat = _translate("DateFormat");
    timeFormat = _translate("TimeFormat");
    dateTimeFormat = _translate("DateTimeFormat");
    dateHint = _translate("DateHint");
    okButton = _translate("OkButton");
    cancelButton = _translate("CancelButton");
    yesButton = _translate("YesButton");
    noButton = _translate("NoButton");
    deleteButton = _translate("DeleteButton");
    editButton = _translate("EditButton");
    saveButton = _translate("SaveButton");
    backButton = _translate("BackButton");
    addButton = _translate("AddButton");
    filterButton = _translate("FilterButton");
    clearButton = _translate("ClearButton");
    sortButton = _translate("SortButton");
    id = _translate("Id");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
