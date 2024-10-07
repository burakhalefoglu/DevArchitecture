import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/routes/routes_constants.dart';
import 'base_state.dart';

class BlocFailedMiddleware {
  static void handleBlocFailed(BuildContext context, BaseState state) {
    if (state is BlocFailed) {
      // Merkezi hata yakalama sistemi
      switch (state.statusCode) {
        case 400:
          // Hata mesajı kodu
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          break;
        case 401:
          // Token hatası, login ekranına geri dön
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          Navigator.pushReplacementNamed(context, RoutesConstants.loginPage);
          break;
        case 403:
          // Yetki hatası, anasayfaya dön
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          Navigator.pushReplacementNamed(context, RoutesConstants.appHomePage);
          break;
        case 404:
          // Sayfa bulunamadı, anasayfaya dön
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          Navigator.pushReplacementNamed(context, RoutesConstants.appHomePage);
          break;
        case 500:
          // Hata mesajı kodu
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          // Bilinmeyen hata, bir hata oluştu mesajı dön
          print('Bir hata oluştu');
          break;
        default:
          // Bilinmeyen hata, bir hata oluştu mesajı dön
          // TODO: localizasyon yapılacak.
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getErrorMessage(state.message);
          print('Bir hata oluştu');
          break;
      }
    }
  }
}
