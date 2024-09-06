import '../../../../core/services/base_services/in_memory_service.dart';
import '../models/language.dart';
import 'i_language_service.dart';

class InMemoryLanguageService extends InMemoryService<Language>
    implements ILanguageService {
  List<Language> _languages = [
    Language(id: 1, code: "tr-TR", name: "Türkçe"),
    Language(id: 2, code: "en-EN", name: "English"),
  ];

  InMemoryLanguageService() {
    super.datas = _languages.map((e) => e.toMap()).toList();
  }
}
