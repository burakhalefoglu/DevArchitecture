import 'package:flutter_devarchitecture/features/theme/color_palette_page.dart';
import 'package:flutter_devarchitecture/features/utilities/screen_message_page.dart';

import '../features/utilities/Share/csv_share_button_page.dart';
import '../features/utilities/Share/excel_share_button_page.dart';
import '../features/utilities/Share/image_share_button_page.dart';
import '../features/utilities/Share/json_share_button_page.dart';
import '../features/utilities/Share/pdf_share_button_page.dart';
import '../features/utilities/Share/txt_share_button_page.dart';
import '../features/utilities/Share/xml_share_button_page.dart';
import '../features/utilities/internet_connection_page.dart';
import '../features/utilities/local_notification_page.dart';
import '../features/widgets/input_examples_page.dart';
import '/features/admin_panel/languages/admin_language_page.dart';
import '/features/admin_panel/users/pages/admin_user_page.dart';
import '/features/utilities/Download/csv_download_button_page.dart';
import '/features/utilities/Download/excel_download_button_page.dart';
import '/features/utilities/Download/image_download_button_page.dart';
import '/features/utilities/Download/json_download_button_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../core/guard/auth_guard.dart';
import '../features/admin_panel/groups/admin_group_page.dart';
import '../features/admin_panel/logs/logs.dart';
import '../features/admin_panel/operation_claims/admin_operation_claim_page.dart';
import '../features/admin_panel/translates/admin_translate_page.dart';
import '../features/app_panel/home/home_page.dart';
import '../features/public/auth/login_page.dart';
import '../features/public/not_found/not_found_page.dart';
import '../features/utilities/Download/pdf_download_button_page.dart';
import '../features/utilities/Download/txt_download_button_page.dart';
import '../features/utilities/Download/xml_download_button_page.dart';
import '../features/utilities/battery_status_page.dart';
import '../features/utilities/biometric_auth_page.dart';
import '../features/utilities/device_info_page.dart';
import 'routes_constants.dart';

class AppRouteModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthStore>(AuthStore.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    var transition = TransitionType.fadeIn;

    // ADMIN LAYOUT
    //*? ADMIN HOME PAGE
    r.child(RoutesConstants.adminHomePage,
        child: (context) => const HomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN USER PAGE
    r.child(RoutesConstants.adminUserPage,
        child: (context) => const AdminUserPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN GROUP PAGE
    r.child(RoutesConstants.adminGroupPage,
        child: (context) => const AdminGroupPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN OPERATION CLAIM PAGE
    r.child(RoutesConstants.adminOperationClaimPage,
        child: (context) => const AdminOperationClaimPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN LANGUAGE PAGE
    r.child(RoutesConstants.adminLanguagePage,
        child: (context) => const AdminLanguagePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN TRANSLATE PAGE
    r.child(RoutesConstants.adminTranslatePage,
        child: (context) => const AdminTranslatePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN LOG PAGE
    r.child(RoutesConstants.adminLogPage,
        child: (context) => const AdminLogPage(),
        transition: transition,
        guards: [AuthGuard()]);

    // APP LAYOUT
    //*? HOME PAGE
    r.child(RoutesConstants.appHomePage,
        child: (context) => const HomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    // PUBLIC LAYOUT
    //*? LOGIN PAGE
    r.child(RoutesConstants.loginPage,
        child: (context) => LoginPage(), transition: transition);

    //*? WILDCARD
    r.wildcard(
      child: (context) => const NotFoundPage(),
      transition: transition,
    );

    //UTILITIES
    //*? Battery Status Page
    r.child(RoutesConstants.batteryStatusPage,
        child: (context) => BatteryStatusPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? Biometric Auth Page
    r.child(RoutesConstants.biometricAuthPage,
        child: (context) => BiometricAuthPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? Device Info Page
    r.child(RoutesConstants.deviceInfoPage,
        child: (context) => DeviceInfoPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? DOWNLOAD PAGES
    r.child(RoutesConstants.excelDownloadPage,
        child: (context) => ExcelDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.csvDownloadPage,
        child: (context) => CsvDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.imageDownloadPage,
        child: (context) => ImageDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.jsonDownloadPage,
        child: (context) => JsonDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.pdfDownloadPage,
        child: (context) => PdfDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.txtDownloadPage,
        child: (context) => TxtDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.xmlDownloadPage,
        child: (context) => XmlDownloadPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? SHARE PAGES
    r.child(RoutesConstants.xmlSharePage,
        child: (context) => XmlSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.pdfSharePage,
        child: (context) => PdfSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.excelSharePage,
        child: (context) => ExcelSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.csvSharePage,
        child: (context) => CsvSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.imageSharePage,
        child: (context) => ImageSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.txtSharePage,
        child: (context) => TxtSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.jsonSharePage,
        child: (context) => JsonSharePage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.internetConnectionPage,
        child: (context) => InternetConnectionPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.localNotificationPage,
        child: (context) => LocalNotificationPage(),
        transition: transition,
        guards: [AuthGuard()]);

    r.child(RoutesConstants.screenMessagePage,
        child: (context) => ScreenMessagePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? theme pages
    r.child(RoutesConstants.colorPalettePage,
        child: (context) => ColorPalettePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? widgets
    r.child(RoutesConstants.inputFieldPage,
        child: (context) => InputExamplesPage(),
        transition: transition,
        guards: [AuthGuard()]);
  }
}
