import '../../../../di/core_initializer.dart';
import '../../../../services/base_services/api_service.dart';
import '../../../../utilities/results.dart';
import '../models/translate.dart';
import '../models/translate_dto.dart';
import 'i_translate_service.dart';

class ApiTranslateService extends ApiService<Translate>
    implements ITranslateService {
  ApiTranslateService({required super.method});

  @override
  Future<IDataResult<List<TranslateDto>>> getTranslates() async {
    var result = await CoreInitializer().coreContainer.http.get("$url/dtos/");
    if (result["success"] != null) {
      if (result["success"] == false) {
        return Future.value(FailureDataResult(result["message"] ?? ""));
      }
    }
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(SuccessDataResult(
        data.map((e) => TranslateDto.fromMap(e)).toList(), ""));
  }
}
