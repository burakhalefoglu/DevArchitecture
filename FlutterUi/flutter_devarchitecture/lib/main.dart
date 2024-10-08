import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/di/core_initializer.dart';
import 'core/di/firebase/firebase_initializer.dart';
import 'core/mixins/battery_state_mixin.dart';
import 'core/mixins/internet_connection_mixin.dart';
import 'features/mixin/modular_mixin.dart';
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

  runApp(MyApp());
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
  Widget buildChild(BuildContext context) {
    listenConnection();
    listenBatteryState();

    // * implement Modular for Pages and Routes
    return buildModular(context);
  }
}
