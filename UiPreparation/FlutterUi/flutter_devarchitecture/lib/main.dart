// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'core/constants/temp/messages.dart';
import 'core/constants/temp/screen_element_constants.dart';
import 'core/di/core_initializer.dart';
import 'core/di/firebase/firebase_initializer.dart';
import 'core/helpers/translation_provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/constants/temp/sidebar_constants.dart';
import 'modular_mixin.dart';
import 'core/mixins/internet_connection_mixin.dart';
import 'core/mixins/ok_toast_mixin.dart';
import 'di/business_initializer.dart';

Future<void> main() async {
  //? Initializers
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );
  await injectFirebaseUtils();
  CoreInitializer();
  BusinessInitializer();

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

Future<void> injectFirebaseUtils() async {
  const isFirebaseEnabled = bool.fromEnvironment('FIREBASE');
  if (isFirebaseEnabled) {
    FirebaseInitializer();
  }
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
    with OKToastMixin<App>, InternetConnectionCheckerMixin, ModularMixin {
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
    //! please init constants here!
    Messages.init(context);
    SidebarConstants.init(context);
    ScreenElementConstants.init(context);
    return buildChild(context);
  }

  @override
  Widget buildChild(BuildContext context) {
    // TODO: connection pop up
    listenConnection();
    return buildModular(context);
  }

  @override
  void dispose() {
    super.dispose();
    stopCheckingConnection();
  }
}
