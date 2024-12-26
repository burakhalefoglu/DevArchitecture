import 'package:flutter/material.dart';

import 'base_constants.dart';

class CommonMessageConstants extends MessageConstantsBase {
  static late String validationError;
  static late String internetConnectionError;
  static late String defaultSuccess;

  static void init(BuildContext context) {
    BaseConstants.init(context);
    validationError = BaseConstants.translate("ValidationError");
    internetConnectionError =
        BaseConstants.translate("InternetConnectionError");
    defaultSuccess = BaseConstants.translate("DefaultSuccess");
  }
}
