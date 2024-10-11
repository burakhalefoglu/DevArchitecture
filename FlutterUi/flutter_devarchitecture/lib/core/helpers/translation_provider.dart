import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/di/business_initializer.dart';

class TranslationProvider with ChangeNotifier {
  final translationService =
      BusinessInitializer().businessContainer.translateService;
  Map<String, String> _translations = {};
  Locale _locale = Locale('tr');

  Map<String, String> get translations => _translations;
  Locale get locale => _locale;

  Future<void> _loadTranslations(String code) async {
    var result = await translationService.getTranslatesByCode(code);
    if (result.isSuccess) {
      _translations.clear();
      result.data!.forEach((key, value) {
        _translations[key] = value;
        print("key: " + key + " value: " + value);
      });
      notifyListeners(); // notifyListeners'ı burada çağırarak güncellemeleri tetikleyin
    } else {
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage(result.message);
    }
  }

  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _loadTranslations(languageCode);
  }

  String translate(String key) {
    return _translations[key] ?? key;
  }
}
