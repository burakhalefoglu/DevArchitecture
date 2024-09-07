import 'package:flutter_devarchitecture/core/models/lookup.dart';

import '../../../../core/bloc/base_state.dart';
import '../models/language.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../di/business_initializer.dart';

class LanguageCubit extends BaseCubit<Language> {
  LanguageCubit() : super() {
    super.service = BusinessInitializer().businessContainer.languageService;
  }

  Future<void> getLanguageCodes() async {
    emit(BlocLoading("Diller getiriliyor..."));
    try {
      // Diller getiriliyor
      final languages = await BusinessInitializer()
          .businessContainer
          .languageService
          .getLanguageCodes();
      emit(BlocSuccess<List<LookUp>>(languages.data!));
    } catch (e) {
      emit(BlocFailed("Diller getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> getLanguageLookups() async {
    emit(BlocLoading("Diller getiriliyor..."));
    try {
      // Diller getiriliyor
      final languages = await BusinessInitializer()
          .businessContainer
          .languageService
          .getLanguageLookups();
      emit(BlocSuccess<List<LookUp>>(languages.data!));
    } catch (e) {
      emit(BlocFailed("Diller getirilemedi: ${e.toString()}"));
    }
  }
}
