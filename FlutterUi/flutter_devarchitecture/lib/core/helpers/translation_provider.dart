import 'package:flutter/material.dart';
import '/core/di/core_initializer.dart';
import '/di/business_initializer.dart';

class TranslationProvider with ChangeNotifier {
  final translationService =
      BusinessInitializer().businessContainer.translateService;
  final localStorageService = CoreInitializer().coreContainer.storage;

  static Map<String, String> _translations = {};
  static Locale _locale = Locale('tr');

  Map<String, String> get translations => _translations;
  Locale get locale => _locale;

  Future<void> loadTranslations(String code) async {
    var result = await translationService.getTranslatesByCode(code);
    if (result.isSuccess) {
      _translations.clear();
      result.data!.forEach((key, value) {
        _translations[key] = value;
      });
      notifyListeners();
    } else {
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage(result.message);
    }
  }

  Future<void> changeLocale(String languageCode) async {
    String? storedLanguageCode =
        await localStorageService.read('current_language_code');

    if (storedLanguageCode == languageCode) {
      return;
    }

    _locale = Locale(languageCode);
    await localStorageService.save('current_language_code', languageCode);
    await loadTranslations(languageCode);
  }

  String translate(String key) {
    return _translations[key] ?? key;
  }
}
