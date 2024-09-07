import '../../../../core/di/core_initializer.dart';
import '../../../../core/services/base_services/api_service.dart';
import '../../../../core/utilities/results.dart';
import '../../user-claims/models/lookup.dart';
import '../models/language.dart';
import 'i_language_service.dart';

class ApiLanguageService extends ApiService<Language>
    implements ILanguageService {
  ApiLanguageService({required super.method});

  @override
  Future<IDataResult<List<LookUp>>> getLanguages() async {
    var result = await CoreInitializer().coreContainer.http.get(url + "/codes");
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();

    return Future.value(
        SuccessDataResult(data.map((e) => LookUp.fromMap(e)).toList(), ""));
  }
}
