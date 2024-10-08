import '../../../../core/services/i_service.dart';
import '../../../../core/utilities/results.dart';
import '../models/translate_dto.dart';

abstract class ITranslateService implements IService {
  Future<IDataResult<List<TranslateDto>>> getTranslates();
  Future<IDataResult<Map<String, dynamic>>> getTranslatesByCode(String code);
}
