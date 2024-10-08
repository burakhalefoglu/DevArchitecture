import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/di/business_initializer.dart';
import '../utilities/results.dart';

class TranslationProvider with ChangeNotifier {
  final translationService =
      BusinessInitializer().businessContainer.translateService;
  Map<String, String> _translations = {};
  Locale _locale = Locale('en');

  Map<String, String> get translations => _translations;
  Locale get locale => _locale;

  Future<void> loadTranslations(String code) async {
    var localStorageService = CoreInitializer().coreContainer.storage;
    String? savedTranslations =
        await localStorageService.read('translations_$code');

    if (savedTranslations != null) {
      _translations = Map<String, String>.from(jsonDecode(savedTranslations));
    } else {
      var result = await translationService.getTranslatesByCode(code);
      if (result is SuccessDataResult) {
        localStorageService.save(
            'translations_$code', jsonEncode(_translations));
      } else {
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getErrorMessage(result.message);
      }
    }
    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await loadTranslations(languageCode);
    var localStorageService = CoreInitializer().coreContainer.storage;
    await localStorageService.save('language_code', languageCode);
    notifyListeners();
  }

  String translate(String key) {
    return _translations[key] ?? key;
  }

  Future<void> loadInitialLocale() async {
    var localStorageService = CoreInitializer().coreContainer.storage;
    String? languageCode = await localStorageService.read('language_code');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      await loadTranslations(languageCode);
    }
    notifyListeners();
  }
}
