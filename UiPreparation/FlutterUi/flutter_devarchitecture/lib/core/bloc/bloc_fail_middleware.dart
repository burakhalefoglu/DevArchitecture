import 'package:flutter/material.dart';
import '/extensions/translate_provider_extension.dart';
import '../../routes/routes_constants.dart';
import '../constants/core_messages.dart';
import '../di/core_initializer.dart';
import 'base_state.dart';

class BlocFailedMiddleware {
  static void handleBlocFailed(BuildContext context, BaseState state) {
    if (state is BlocFailed) {
      var message = "";
      // context.translationProvider.translate(state.message);

      switch (state.statusCode) {
        case 400:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(message);
          break;
        case 401:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(message);
          Navigator.pushReplacementNamed(context, RoutesConstants.loginPage);
          break;
        case 403:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(message);
          Navigator.pushReplacementNamed(context, RoutesConstants.appHomePage);
          break;
        case 404:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(message);
          Navigator.pushReplacementNamed(context, RoutesConstants.appHomePage);
          break;
        case 500:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(CoreMessages.customerDefaultErrorMessage);
          break;
        default:
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(CoreMessages.customerDefaultErrorMessage);
          break;
      }
    }
  }
}
