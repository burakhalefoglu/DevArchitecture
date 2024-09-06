import '../../../../core/di/core_initializer.dart';
import '../../../../core/services/base_services/api_service.dart';
import '../../../../core/utilities/results.dart';
import '../models/translate.dart';
import '../models/translate_dto.dart';
import 'i_translate_service.dart';

class ApiTranslateService extends ApiService<Translate>
    implements ITranslateService {
  ApiTranslateService({required super.method});

  @override
  Future<IDataResult<List<TranslateDto>>> getTranslates() async {
    var result = await CoreInitializer().coreContainer.http.get("$url/dtos/");
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(SuccessDataResult(
        data.map((e) => TranslateDto.fromMap(e)).toList(), ""));
  }
}
