import '../models/translate.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../di/business_initializer.dart';

class TranslateCubit extends BaseCubit<Translate> {
  TranslateCubit() : super() {
    super.service = BusinessInitializer().businessContainer.translateService;
  }
}
