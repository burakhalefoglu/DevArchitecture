import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'core/constants/messages.dart';
import 'core/constants/screen_element_constants.dart';
import 'core/di/core_initializer.dart';
import 'core/di/firebase/firebase_initializer.dart';
import 'core/helpers/translation_provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/constants/sidebar_constants.dart';
import 'features/mixin/modular_mixin.dart';
import 'core/mixins/battery_state_mixin.dart';
import 'core/mixins/internet_connection_mixin.dart';
import 'core/mixins/ok_toast_mixin.dart';
import 'di/business_initializer.dart';

Future<void> main() async {
  //? Initializers
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  CoreInitializer();
  BusinessInitializer();

  if (String.fromEnvironment('FIREBASE') == 'true') {
    //! IF Firebase Initializer  is FALSE  don't use -> 'FirebaseInitializer().firebaseContainer'
    //! The exception will be thrown not implemented

    //? Firebase Options will be used in FirebaseInitializer
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    FirebaseInitializer();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TranslationProvider(),
        ),
      ],
      child: OKToast(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>
    with
        OKToastMixin<App>,
        InternetConnectionCheckerMixin,
        BatteryStateMixin,
        ModularMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<TranslationProvider>(context, listen: false)
          .loadTranslations("tr-TR");
    });
  }

  @override
  Widget build(BuildContext context) {
    //: init constants
    Messages.init(context);
    SidebarConstants.init(context);
    ScreenElementConstants.init(context);
    return buildChild(context);
  }

  @override
  Widget buildChild(BuildContext context) {
    listenConnection();
    listenBatteryState();

    return buildModular(context);
  }

  @override
  void dispose() {
    super.dispose();
    stopCheckingConnection();
    stopListeningBatteryState();
  }
}
