// class Messages {
//   // info messages
//   static String formValidationErrorMessage =
//       "Lütfen eksik bilgileri doldurun ve tekrar deneyin.";
//   static String customerDefaultHttpMessage = "Veriler getiriliyor";
//   static String customerDefaultCalculateMessage = "Hesaplama yapılıyor";
//   static String customerSaveInfoMessage = "Kayıt İşlemi Yapılıyor...";
//   static String customerInternetConnectionSuccessMessage =
//       "İnternet Bağlanısı başarılı!";
//   // warning messages
//   static String customerDefaultWarningMessage = "Bir problem olabilir.";

//   // error messages
//   static String customerInternetConnectionErrorMessage =
//       "İnternet Bağlanıtızı kontrol ediniz!";
//   static String customerDefaultErrorMessage = "Bir hata oluştu";
//   static String companyNameinputFieldWidgetEmptyErrorMessage =
//       "Firma Adı Boş Geçilemez!";

//   // success messages
//   static String customerSuccessHttpMessage = "Veriler hazır";
//   static String customerSuccessSaveMessage = "Kayıt İşlemi Başarılı!";
//   static String customerSuccessCalculateMessage = "Hesaplama Tamamlandı!";

//   static String fuelInputErrorMessage = "Yakıt Alım Miktarı Kapasiteyi Aşıyor!";

//   static var fuelSpendErrorMessage = "Yakıt Harcama Geçerli Miktarı Aşıyor!";

//   static String customerAddSuccessMessage = "Veri Eklendi...";

//   static String checkSuccessMessage =
//       "Veri kontrolü başarılı!, Sisteme gönderiliyor...";
// }

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

  /// Uygulama başlatıldığında bir kez çağrılır.
  static void init(BuildContext context) {
    _context = context;

    formValidationErrorMessage = _translate("formValidationErrorMessage");
    customerDefaultHttpMessage = _translate("customerDefaultHttpMessage");
    customerDefaultCalculateMessage =
        _translate("customerDefaultCalculateMessage");
    customerSaveInfoMessage = _translate("customerSaveInfoMessage");
    customerInternetConnectionSuccessMessage =
        _translate("customerInternetConnectionSuccessMessage");

    customerDefaultWarningMessage = _translate("customerDefaultWarningMessage");

    customerInternetConnectionErrorMessage =
        _translate("customerInternetConnectionErrorMessage");
    customerDefaultErrorMessage = _translate("customerDefaultErrorMessage");
    companyNameInputFieldWidgetEmptyErrorMessage =
        _translate("companyNameInputFieldWidgetEmptyErrorMessage");

    customerSuccessHttpMessage = _translate("customerSuccessHttpMessage");
    customerSuccessSaveMessage = _translate("customerSuccessSaveMessage");
    customerSuccessCalculateMessage =
        _translate("customerSuccessCalculateMessage");

    fuelInputErrorMessage = _translate("fuelInputErrorMessage");
    fuelSpendErrorMessage = _translate("fuelSpendErrorMessage");

    customerAddSuccessMessage = _translate("customerAddSuccessMessage");
    checkSuccessMessage = _translate("checkSuccessMessage");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
