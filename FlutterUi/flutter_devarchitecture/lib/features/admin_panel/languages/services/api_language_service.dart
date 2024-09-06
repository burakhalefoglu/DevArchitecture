import '../../../../core/services/base_services/api_service.dart';
import '../models/language.dart';
import 'i_language_service.dart';

class ApiLanguageService extends ApiService<Language>
    implements ILanguageService {
  ApiLanguageService({required super.method});
}
