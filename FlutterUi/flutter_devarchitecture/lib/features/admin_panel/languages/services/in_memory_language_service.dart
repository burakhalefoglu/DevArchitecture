import '../../../../core/services/base_services/in_memory_service.dart';
import '../../../../core/utilities/results.dart';
import '../../user-claims/models/lookup.dart';
import '../models/language.dart';
import 'i_language_service.dart';

class InMemoryLanguageService extends InMemoryService<Language>
    implements ILanguageService {
  List<Language> _languages = [
    Language(id: 1, code: "tr-TR", name: "Türkçe"),
    Language(id: 2, code: "en-EN", name: "English"),
  ];

  List<LookUp> _lookUps = [
    LookUp(id: "tr-TR", label: "Türkçe"),
    LookUp(id: "en-EN", label: "English"),
  ];

  InMemoryLanguageService() {
    super.datas = _languages.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<LookUp>>> getLanguages() async {
    return SuccessDataResult(
        _lookUps.map((e) => LookUp.fromMap(e.toMap())).toList(), "");
  }
}
