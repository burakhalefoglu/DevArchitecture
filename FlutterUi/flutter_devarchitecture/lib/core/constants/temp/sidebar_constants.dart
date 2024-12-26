import 'package:flutter/material.dart';
import '../base_constants.dart';

class SidebarConstants extends SidebarConstantsBase {
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

  SidebarConstants(BuildContext context) : super(context) {
    init();
  }
  void init() {
    homePageTitle = translate("HomePageTitle");

    adminPanelPageTitle = translate("AdminPanelPageTitle");
    adminPanelHomePageTitle = translate("AdminPanelHomePageTitle");
    adminPanelPageUserTitle = translate("AdminPanelPageUserTitle");
    adminPanelPageGroupTitle = translate("AdminPanelPageGroupTitle");
    adminPanelPageOperationClaimTitle =
        translate("AdminPanelPageOperationClaimTitle");
    adminPanelPageLanguageTitle = translate("AdminPanelPageLanguageTitle");
    adminPanelPageTranslateTitle = translate("AdminPanelPageTranslateTitle");
    adminPanelPageLogTitle = translate("AdminPanelPageLogTitle");

    appPanelPageTitle = translate("AppPanelPageTitle");

    utilitiesPageTitle = translate("UtilitiesPageTitle");
    batteryStatusPageTitle = translate("BatteryStatusPageTitle");
    biometricAuthPageTitle = translate("BiometricAuthPageTitle");
    deviceInfoPageTitle = translate("DeviceInfoPageTitle");

    downloadPageTitle = translate("DownloadPageTitle");
    excelDownloadPageTitle = translate("ExcelDownloadPageTitle");
    pdfDownloadPageTitle = translate("PdfDownloadPageTitle");
    csvDownloadPageTitle = translate("CsvDownloadPageTitle");
    jsonDownloadPageTitle = translate("JsonDownloadPageTitle");
    xmlDownloadPageTitle = translate("XmlDownloadPageTitle");
    imageDownloadPageTitle = translate("ImageDownloadPageTitle");
    txtDownloadPageTitle = translate("TxtDownloadPageTitle");

    sharePageTitle = translate("SharePageTitle");
    excelSharePageTitle = translate("ExcelSharePageTitle");
    pdfSharePageTitle = translate("PdfSharePageTitle");
    csvSharePageTitle = translate("CsvSharePageTitle");
    jsonSharePageTitle = translate("JsonSharePageTitle");
    xmlSharePageTitle = translate("XmlSharePageTitle");
    imageSharePageTitle = translate("ImageSharePageTitle");
    txtSharePageTitle = translate("TxtSharePageTitle");

    internetConnectionPageTitle = translate("InternetConnectionPageTitle");
    localNotificationPageTitle = translate("LocalNotificationPageTitle");
    screenMessagePageTitle = translate("ScreenMessagePageTitle");
    loggerPageTitle = translate("LoggerPageTitle");
    permissionPageTitle = translate("PermissionPageTitle");
    qrCodeScannerPageTitle = translate("QrCodeScannerPageTitle");

    templatesPageTitle = translate("TemplatesPageTitle");
    colorPalettePageTitle = translate("ColorPalettePageTitle");

    widgetsPageTitle = translate("WidgetsPageTitle");
    inputExamplesPageTitle = translate("InputExamplesPageTitle");
  }
}
