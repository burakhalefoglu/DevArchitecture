import 'package:flutter/material.dart';
import 'core/di/core_initializer.dart';
import 'core/di/firebase/firebase_initializer.dart';
import 'core/mixins/battery_state_mixin.dart';
import 'core/mixins/internet_connection_mixin.dart';
import 'features/mixin/modular_mixin.dart';
import 'core/mixins/ok_toast_mixin.dart';
import 'di/business_initializer.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  //? Initializers
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  CoreInitializer();
  BusinessInitializer();

  if (String.fromEnvironment('FIREBASE') == 'true') {
    // ? Firebase Initializer. if close  don't use -> 'FirebaseInitializer().firebaseContainer'
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
        InternetConnectionCheckerMixin,
        BatteryStateMixin,
        OKToastMixin<App>,
        ModularMixin {
  @override
  Widget buildChild(BuildContext context) {
    listenConnection();
    listenBatteryState();

    // * implement Modular for Pages and Routes
    return buildModular(context);
  }
}
