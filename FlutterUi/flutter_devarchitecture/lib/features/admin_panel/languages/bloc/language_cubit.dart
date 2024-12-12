import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

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
      final languagesResult = await BusinessInitializer()
          .businessContainer
          .languageService
          .getLanguageCodes();

      if (!languagesResult.isSuccess) {
        emitFailState(languagesResult.message);
        return;
      }
      emit(BlocSuccess<List<LookUp>>(languagesResult.data!));
    } on Exception catch (e) {
      emitFailState("", e: e);
    }
  }

  Future<void> getLanguageLookups() async {
    emit(BlocLoading("Diller getiriliyor..."));
    try {
      final result = await BusinessInitializer()
          .businessContainer
          .languageService
          .getLanguageLookups();
      if (!result.isSuccess) {
        emitFailState(result.message);
        return;
      }
      emit(BlocSuccess<List<LookUp>>(result.data!));
    } on Exception catch (e) {
      emitFailState("", e: e);
    }
  }
}
