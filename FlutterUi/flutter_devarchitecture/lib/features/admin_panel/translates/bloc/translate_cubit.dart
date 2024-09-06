import '../models/translate.dart';
import '../models/translate_dto.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class TranslateCubit extends BaseCubit<Translate> {
  TranslateCubit() : super() {
    super.service = BusinessInitializer().businessContainer.translateService;
  }

  Future<void> getTranslates() async {
    emit(BlocLoading("Çeviriler getiriliyor..."));
    try {
      // Çeviriler getiriliyor
      final translates = await BusinessInitializer()
          .businessContainer
          .translateService
          .getTranslates();
      emit(BlocSuccess<List<TranslateDto>>(
        translates.data!,
      ));
    } catch (e) {
      emit(BlocFailed("Çeviriler getirilemedi: ${e.toString()}"));
    }
  }
}
