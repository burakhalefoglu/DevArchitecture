import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/theme/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../core/helpers/translation_provider.dart';

mixin ModularMixin {
  Widget buildModular(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TranslationProvider(),
        ),
      ],
      child: Consumer2<ThemeProvider, TranslationProvider>(
        builder: (context, themeProvider, translationProvider, child) {
          return MaterialApp.router(
            locale: translationProvider.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('tr', 'TR'),
              Locale('de', 'DE'),
              Locale('es', 'ES'),
              Locale('fr', 'FR'),
              Locale('it', 'IT'),
              Locale('pt', 'PT'),
              Locale('ru', 'RU'),
              Locale('ja', 'JP'),
              Locale('zh', 'CN'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
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
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: Modular.routerConfig,
          );
        },
      ),
    );
  }
}
