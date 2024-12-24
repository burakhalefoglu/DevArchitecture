import 'package:flutter/material.dart';

import 'base_constants.dart';

class CommonMessageConstants extends MessageConstantsBase {
  late String validationError;
  late String internetConnectionError;
  late String defaultSuccess;

  CommonMessageConstants(BuildContext context) : super(context) {
    init();
  }

  void init() {
    validationError = translate("ValidationError");
    internetConnectionError = translate("InternetConnectionError");
    defaultSuccess = translate("DefaultSuccess");
  }
}
