// class SidebarConstants {
//   static const String homePageTitle = "Anasayfa";

//   static const String adminPanelPageTitle = "Yönetim";
//   static const String adminPanelHomePageTitle = "Admin Paneli";
//   static const String adminPanelPageUserTitle = "Kullanıcılar";
//   static const String adminPanelPageGroupTitle = "Gruplar";
//   static const String adminPanelPageOperationClaimTitle = "Operasyon Yetkileri";
//   static const String adminPanelPageLanguageTitle = "Diller";
//   static const String adminPanelPageTranslateTitle = "Dil Çevirileri";
//   static const String adminPanelPageLogTitle = "Log Kayıtları";

//   static const String appPanelPageTitle = "Uygulama";

//   // Utilities
//   static const String utilitiesPageTitle = "Utilities";
//   static const String batteryStatusPageTitle = "Batarya Durumu";
//   static const String biometricAuthPageTitle = "Biyometrik Kimlik Dogrulama";
//   static const String deviceInfoPageTitle = "Cihaz Bilgileri";

//   static const String downloadPageTitle = "İndirme İşlemleri";
//   static const String excelDownloadPageTitle = "Excel";
//   static const String pdfDownloadPageTitle = "PDF";
//   static const String csvDownloadPageTitle = "CSV";
//   static const String jsonDownloadPageTitle = "JSON";
//   static const String xmlDownloadPageTitle = "XML";
//   static const String imageDownloadPageTitle = "Resim";
//   static const String txtDownloadPageTitle = "TXT";

//   static const String sharePageTitle = "Paylaşım İşlemleri";
//   static const String excelSharePageTitle = "Excel";
//   static const String pdfSharePageTitle = "PDF";
//   static const String csvSharePageTitle = "CSV";
//   static const String jsonSharePageTitle = "JSON";
//   static const String xmlSharePageTitle = "XML";
//   static const String imageSharePageTitle = "Resim";
//   static const String txtSharePageTitle = "TXT";

//   static const String internetConnectionPageTitle = "İnternet Bağlantısı";
//   static const String localNotificationPageTitle = "Yerel Bildirimler";
//   static const String screenMessagePageTitle = "Ekran Mesajı";
//   static const String loggerPageTitle = "Log İşlemleri";
//   static const String permissionPageTitle = "İzinler";
//   static const String qrCodeScannerPageTitle = "QR Kod Okuma";

//   // templates
//   static const String templatesPageTitle = "Tema";
//   static const String colorPalettePageTitle = "Renk Paleti";

//   // widgets
//   static const String widgetsPageTitle = "Widgetler";
//   static const String inputExamplesPageTitle = "Girdi Olayları";
// }

import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/helpers/translate_provider_extension.dart';

class SidebarConstants {
  static late BuildContext _context;

  static late String homePageTitle;

  static late String adminPanelPageTitle;
  static late String adminPanelHomePageTitle;
  static late String adminPanelPageUserTitle;
  static late String adminPanelPageGroupTitle;
  static late String adminPanelPageOperationClaimTitle;
  static late String adminPanelPageLanguageTitle;
  static late String adminPanelPageTranslateTitle;
  static late String adminPanelPageLogTitle;

  static late String appPanelPageTitle;

  // Utilities
  static late String utilitiesPageTitle;
  static late String batteryStatusPageTitle;
  static late String biometricAuthPageTitle;
  static late String deviceInfoPageTitle;

  static late String downloadPageTitle;
  static late String excelDownloadPageTitle;
  static late String pdfDownloadPageTitle;
  static late String csvDownloadPageTitle;
  static late String jsonDownloadPageTitle;
  static late String xmlDownloadPageTitle;
  static late String imageDownloadPageTitle;
  static late String txtDownloadPageTitle;

  static late String sharePageTitle;
  static late String excelSharePageTitle;
  static late String pdfSharePageTitle;
  static late String csvSharePageTitle;
  static late String jsonSharePageTitle;
  static late String xmlSharePageTitle;
  static late String imageSharePageTitle;
  static late String txtSharePageTitle;

  static late String internetConnectionPageTitle;
  static late String localNotificationPageTitle;
  static late String screenMessagePageTitle;
  static late String loggerPageTitle;
  static late String permissionPageTitle;
  static late String qrCodeScannerPageTitle;

  // Templates
  static late String templatesPageTitle;
  static late String colorPalettePageTitle;

  // Widgets
  static late String widgetsPageTitle;
  static late String inputExamplesPageTitle;

  /// Uygulama başlatıldığında bir kez çağrılır.
  static void init(BuildContext context) {
    _context = context;

    homePageTitle = _translate("homePageTitle");

    adminPanelPageTitle = _translate("adminPanelPageTitle");
    adminPanelHomePageTitle = _translate("adminPanelHomePageTitle");
    adminPanelPageUserTitle = _translate("adminPanelPageUserTitle");
    adminPanelPageGroupTitle = _translate("adminPanelPageGroupTitle");
    adminPanelPageOperationClaimTitle =
        _translate("adminPanelPageOperationClaimTitle");
    adminPanelPageLanguageTitle = _translate("adminPanelPageLanguageTitle");
    adminPanelPageTranslateTitle = _translate("adminPanelPageTranslateTitle");
    adminPanelPageLogTitle = _translate("adminPanelPageLogTitle");

    appPanelPageTitle = _translate("appPanelPageTitle");

    utilitiesPageTitle = _translate("utilitiesPageTitle");
    batteryStatusPageTitle = _translate("batteryStatusPageTitle");
    biometricAuthPageTitle = _translate("biometricAuthPageTitle");
    deviceInfoPageTitle = _translate("deviceInfoPageTitle");

    downloadPageTitle = _translate("downloadPageTitle");
    excelDownloadPageTitle = _translate("excelDownloadPageTitle");
    pdfDownloadPageTitle = _translate("pdfDownloadPageTitle");
    csvDownloadPageTitle = _translate("csvDownloadPageTitle");
    jsonDownloadPageTitle = _translate("jsonDownloadPageTitle");
    xmlDownloadPageTitle = _translate("xmlDownloadPageTitle");
    imageDownloadPageTitle = _translate("imageDownloadPageTitle");
    txtDownloadPageTitle = _translate("txtDownloadPageTitle");

    sharePageTitle = _translate("sharePageTitle");
    excelSharePageTitle = _translate("excelSharePageTitle");
    pdfSharePageTitle = _translate("pdfSharePageTitle");
    csvSharePageTitle = _translate("csvSharePageTitle");
    jsonSharePageTitle = _translate("jsonSharePageTitle");
    xmlSharePageTitle = _translate("xmlSharePageTitle");
    imageSharePageTitle = _translate("imageSharePageTitle");
    txtSharePageTitle = _translate("txtSharePageTitle");

    internetConnectionPageTitle = _translate("internetConnectionPageTitle");
    localNotificationPageTitle = _translate("localNotificationPageTitle");
    screenMessagePageTitle = _translate("screenMessagePageTitle");
    loggerPageTitle = _translate("loggerPageTitle");
    permissionPageTitle = _translate("permissionPageTitle");
    qrCodeScannerPageTitle = _translate("qrCodeScannerPageTitle");

    templatesPageTitle = _translate("templatesPageTitle");
    colorPalettePageTitle = _translate("colorPalettePageTitle");

    widgetsPageTitle = _translate("widgetsPageTitle");
    inputExamplesPageTitle = _translate("inputExamplesPageTitle");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
