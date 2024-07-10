import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';

import '/core/theme/extensions.dart';
import 'core/dependency_resolvers/get_it/core_initializer.dart';
import 'core/theme/custom_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'dependency_resolver/business_initializer.dart';
import 'routes/app_route_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();
  CoreInitializer();
  BusinessInitializer();
  runApp(ModularApp(module: AppRouteModule(), child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
        backgroundColor: CustomColors.gray.getColor,
        textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        radius: 10,
        position: ToastPosition.bottom,
        duration: const Duration(seconds: 3),
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('tr', 'TR'),
            Locale('en', 'US'),
          ],
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.invertedStylus,
              PointerDeviceKind.unknown,
            },
          ),
          theme: ThemeData(
            menuTheme: MenuBarThemeData(
                style: MenuStyle(
              backgroundColor:
                  WidgetStateProperty.all(CustomColors.white.getColor),
            )),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: context.lowBorderRadius,
                )),
                backgroundColor: WidgetStateProperty.all(
                    CustomColors.buttonBackgroundPrimary.getColor),
                foregroundColor:
                    WidgetStateProperty.all(CustomColors.white.getColor),
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor:
                      WidgetStateProperty.all(CustomColors.primary.getColor)),
            ),
            iconTheme:
                IconThemeData(size: 26, color: CustomColors.primary.getColor),
            listTileTheme: ListTileThemeData(
              leadingAndTrailingTextStyle: TextStyle(
                color: CustomColors.dark.getColor,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
              titleTextStyle: TextStyle(
                color: CustomColors.primary.getColor,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
              iconColor: CustomColors.primary.getColor,
              selectedColor: CustomColors.white.getColor,
            ),
            colorScheme: ColorScheme.fromSeed(
                background: CustomColors.white.getColor,
                seedColor: CustomColors.primary.getColor,
                primary: CustomColors.primary.getColor),
            useMaterial3: true,
          ),
          routerConfig: Modular.routerConfig,
        ));
  }
}

class SomethingWentWrong extends StatelessWidget {
  final String message;
  const SomethingWentWrong({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message,
      style: TextStyle(fontSize: 20, color: CustomColors.dark.getColor),
    ));
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
