import 'package:flutter/material.dart';
import '/core/helpers/translate_provider_extension.dart';

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

    homePageTitle = _translate("HomePageTitle");

    adminPanelPageTitle = _translate("AdminPanelPageTitle");
    adminPanelHomePageTitle = _translate("AdminPanelHomePageTitle");
    adminPanelPageUserTitle = _translate("AdminPanelPageUserTitle");
    adminPanelPageGroupTitle = _translate("AdminPanelPageGroupTitle");
    adminPanelPageOperationClaimTitle =
        _translate("AdminPanelPageOperationClaimTitle");
    adminPanelPageLanguageTitle = _translate("AdminPanelPageLanguageTitle");
    adminPanelPageTranslateTitle = _translate("AdminPanelPageTranslateTitle");
    adminPanelPageLogTitle = _translate("AdminPanelPageLogTitle");

    appPanelPageTitle = _translate("AppPanelPageTitle");

    utilitiesPageTitle = _translate("UtilitiesPageTitle");
    batteryStatusPageTitle = _translate("BatteryStatusPageTitle");
    biometricAuthPageTitle = _translate("BiometricAuthPageTitle");
    deviceInfoPageTitle = _translate("DeviceInfoPageTitle");

    downloadPageTitle = _translate("DownloadPageTitle");
    excelDownloadPageTitle = _translate("ExcelDownloadPageTitle");
    pdfDownloadPageTitle = _translate("PdfDownloadPageTitle");
    csvDownloadPageTitle = _translate("CsvDownloadPageTitle");
    jsonDownloadPageTitle = _translate("JsonDownloadPageTitle");
    xmlDownloadPageTitle = _translate("XmlDownloadPageTitle");
    imageDownloadPageTitle = _translate("ImageDownloadPageTitle");
    txtDownloadPageTitle = _translate("TxtDownloadPageTitle");

    sharePageTitle = _translate("SharePageTitle");
    excelSharePageTitle = _translate("ExcelSharePageTitle");
    pdfSharePageTitle = _translate("PdfSharePageTitle");
    csvSharePageTitle = _translate("CsvSharePageTitle");
    jsonSharePageTitle = _translate("JsonSharePageTitle");
    xmlSharePageTitle = _translate("XmlSharePageTitle");
    imageSharePageTitle = _translate("ImageSharePageTitle");
    txtSharePageTitle = _translate("TxtSharePageTitle");

    internetConnectionPageTitle = _translate("InternetConnectionPageTitle");
    localNotificationPageTitle = _translate("LocalNotificationPageTitle");
    screenMessagePageTitle = _translate("ScreenMessagePageTitle");
    loggerPageTitle = _translate("LoggerPageTitle");
    permissionPageTitle = _translate("PermissionPageTitle");
    qrCodeScannerPageTitle = _translate("QrCodeScannerPageTitle");

    templatesPageTitle = _translate("TemplatesPageTitle");
    colorPalettePageTitle = _translate("ColorPalettePageTitle");

    widgetsPageTitle = _translate("WidgetsPageTitle");
    inputExamplesPageTitle = _translate("InputExamplesPageTitle");
  }

  static String _translate(String key) {
    return _context.translationProvider.translate(key);
  }
}
