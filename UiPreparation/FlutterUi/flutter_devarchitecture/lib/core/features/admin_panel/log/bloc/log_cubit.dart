import '../models/log_dto.dart';

import '../../../../bloc/base_cubit.dart';
import '../../../../bloc/base_state.dart';
import '../../../../../di/business_initializer.dart';
import '../models/log.dart';

class LogCubit extends BaseCubit<Log> {
  LogCubit() : super() {
    super.service = BusinessInitializer().businessContainer.logService;
  }

  Future<void> getLogs() async {
    emit(BlocLoading());
    try {
      final logs =
          await BusinessInitializer().businessContainer.logService.getLogs();

      if (!logs.isSuccess) {
        emitFailState(logs.message);
        return;
      }
      emit(BlocSuccess<List<LogDto>>(
        logs.data!,
      ));
    } on Exception catch (e) {
      emitFailState("", e: e);
    }
  }
}
