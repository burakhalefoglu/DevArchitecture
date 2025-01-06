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
import 'core/mixins/ok_toast_mixin.dart';
import 'di/business_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
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

class _AppState extends State<App> with OKToastMixin<App>, ModularMixin {
  late Future<void> _initializeTranslations;

  @override
  void initState() {
    super.initState();
    _initializeTranslations =
        Provider.of<TranslationProvider>(context, listen: false)
            .loadTranslations("tr-TR");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeTranslations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Dil yüklenirken gösterilecek bir yüklenme ekranı
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          // Dil yüklenirken hata oluştuysa bir hata ekranı gösterebiliriz
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error loading translations!"),
              ),
            ),
          );
        }

        // Dil başarıyla yüklendiğinde asıl uygulamayı başlat
        Messages.init(context);
        SidebarConstants.init(context);
        ScreenElementConstants.init(context);

        return buildChild(context);
      },
    );
  }

  @override
  Widget buildChild(BuildContext context) {
    return buildModular(context);
  }
}
