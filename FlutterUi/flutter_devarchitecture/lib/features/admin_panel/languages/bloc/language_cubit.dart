import '../models/language.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../di/business_initializer.dart';

class LanguageCubit extends BaseCubit<Language> {
  LanguageCubit() : super() {
    super.service = BusinessInitializer().businessContainer.languageService;
  }
}
