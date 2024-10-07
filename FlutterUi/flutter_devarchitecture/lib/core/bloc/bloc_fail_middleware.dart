import 'package:flutter/material.dart';
import 'base_state.dart';

class BlocFailedMiddleware {
  static void handleBlocFailed(BuildContext context, BaseState state) {
    if (state is BlocFailed) {
      // Merkezi hata yakalama sistemi
      switch (state.statusCode) {
        case 400:
          // Hata mesajı kodu
          print(state.message);
          break;
        case 401:
          // Token hatası, login ekranına geri dön
          Navigator.pushReplacementNamed(context, '/login');
          break;
        case 403:
          // Yetki hatası, anasayfaya dön
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 404:
          // Sayfa bulunamadı, anasayfaya dön
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 500:
          // Bilinmeyen hata, bir hata oluştu mesajı dön
          print('Bir hata oluştu');
          break;
        default:
          // Bilinmeyen hata, bir hata oluştu mesajı dön
          print('Bir hata oluştu');
          break;
      }
    }
  }
}
