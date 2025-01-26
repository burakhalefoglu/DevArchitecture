import 'package:flutter/material.dart';
import '/di/constants_initializer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'core/di/core_initializer.dart';
import 'core/di/firebase/firebase_initializer.dart';
import 'extensions/claim_provider.dart';
import 'extensions/translation_provider.dart';
import 'core/theme/theme_provider.dart';
import 'mixin/modular_mixin.dart';
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
        ChangeNotifierProvider(
          create: (_) => ClaimProvider(),
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
    return MaterialApp(
      home: App(),
    );
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      CoreInitializer()
          .coreContainer
          .internetConnection
          .listenConnection(context);
    });
  }

  @override
  void dispose() {
    CoreInitializer().coreContainer.internetConnection.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConstantsInitializer(context);
    return FutureBuilder<void>(
      future: _initializeTranslations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Bir hata oluştu: ${snapshot.error}"),
              ),
            ),
          );
        }
        return buildChild(context);
      },
    );
  }

  @override
  Widget buildChild(BuildContext context) {
    return buildModular(context);
  }
}
