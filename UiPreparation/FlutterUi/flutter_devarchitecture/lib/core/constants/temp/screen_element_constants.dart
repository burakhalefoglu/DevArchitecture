import 'package:flutter/material.dart';
import '/core/helpers/translate_provider_extension.dart';

class ScreenElementConstants1 {
  static late BuildContext _context;

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

  static late String attention;
  static late String warning;
  static late String success;
  static late String information;

  static late String ok;
  static late String cancel;
  static late String yes;
  static late String no;

  static late String operationClaimList;
  static late String alias;
  static late String aliasHint;
  static late String description;
  static late String updateOperationClaim;
  static late String language;
  static late String translateList;
  static late String codeHint;
  static late String valueHint;

  static late String addTranslate;
  static late String updateTranslate;
  static late String userClaims;
  static late String selectUserClaims;

  static late String users;
  static late String selectUsers;
  static late String userGroups;
  static late String selectUserGroups;
  static late String addUser;
  static late String fullName;
  static late String fullNameHint;

  static late String active;
  static late String inactive;
  static late String notes;
  static late String notesHint;
  static late String changePassword;
  static late String newPassword;
  static late String confirmPassword;
  static late String updateUserClaims;
  static late String updateUserGroups;
  static late String updateUsers;
  static late String userList;
  static late String status;
  static late String mobilePhones;

  static void init(BuildContext context) {
    _context = context;

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

    attention = _translate("Attention");
    warning = _translate("Warning");
    success = _translate("Success");
    information = _translate("Information");
    ok = _translate("Ok");
    cancel = _translate("Cancel");
    yes = _translate("Yes");
    no = _translate("No");

    // backend___________________!

    updateOperationClaim = _translate("UpdateOperationClaim");
    aliasHint = _translate("AliasHint");
    description = _translate("Description");
    operationClaimList = _translate("OperationClaimList");
    language = _translate("Language");
    translateList = _translate("TranslateList");
    codeHint = _translate("CodeHint");
    valueHint = _translate("ValueHint");
    addTranslate = _translate("AddTranslate");
    updateTranslate = _translate("UpdateTranslate");
    userClaims = _translate("UserClaims");
    selectUserClaims = _translate("SelectUserClaims");
    selectUsers = _translate("SelectUsers");
    users = _translate("Users");
    userGroups = _translate("UserGroups");
    selectUserGroups = _translate("SelectUserGroups");
    addUser = _translate("AddUser");
    fullName = _translate("FullName");
    fullNameHint = _translate("FullNameHint");

    active = _translate("Active");
    inactive = _translate("Inactive");
    notes = _translate("Notes");
    notesHint = _translate("NotesHint");
    changePassword = _translate("ChangePassword");
    newPassword = _translate("NewPassword");
    confirmPassword = _translate("ConfirmPassword");
    updateUserClaims = _translate("UpdateUserClaims");
    updateUserGroups = _translate("UpdateUserGroups");
    updateUsers = _translate("UpdateUsers");
    userList = _translate("UserList");
    status = _translate("Status");
    mobilePhones = _translate("MobilePhones");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
