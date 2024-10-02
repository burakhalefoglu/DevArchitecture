import '../../../../services/base_services/in_memory_service.dart';
import '../../../../utilities/results.dart';
import '../../lookups/models/lookup.dart';
import '../models/language.dart';
import 'i_language_service.dart';

class InMemoryLanguageService extends InMemoryService<Language>
    implements ILanguageService {
  List<Language> _languages = [
    Language(id: 1, code: "tr-TR", name: "Türkçe"),
    Language(id: 2, code: "en-EN", name: "English"),
  ];

  List<LookUp> _languageCodes = [
    LookUp(id: "tr-TR", label: "Türkçe"),
    LookUp(id: "en-EN", label: "English"),
  ];

  List<LookUp> _languageLookups = [
    LookUp(id: 1, label: "Türkçe"),
    LookUp(id: 2, label: "English"),
  ];

  InMemoryLanguageService() {
    super.datas = _languages.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<LookUp>>> getLanguageCodes() async {
    return SuccessDataResult(
        _languageCodes.map((e) => LookUp.fromMap(e.toMap())).toList(), "");
  }

  @override
  Future<IDataResult<List<LookUp>>> getLanguageLookups() async {
    return SuccessDataResult(
        _languageLookups.map((e) => LookUp.fromMap(e.toMap())).toList(), "");
  }
}
