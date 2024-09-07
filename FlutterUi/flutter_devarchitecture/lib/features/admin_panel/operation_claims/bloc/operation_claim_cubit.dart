import 'package:flutter/foundation.dart';

import '../models/operation_claim.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../models/operation_claim_dto.dart';

class OperationClaimCubit extends BaseCubit<OperationClaim> {
  OperationClaimCubit() : super() {
    super.service =
        BusinessInitializer().businessContainer.operationClaimService;
  }

  Future<void> updateOperationClaim(OperationClaimDto operationClaimDto) async {
    emit(BlocLoading("Operasyon Yetkileri  güncelleniyor..."));
    try {
      var result =
          await service.update(operationClaimDto.id, operationClaimDto.toMap());
      if (!result.isSuccess) {
        if (kDebugMode) {
          print(result.message);
        }
        emit(BlocFailed(result.message));
        return;
      }
      await getAll();
    } catch (e) {
      emit(BlocFailed("Operasyon yetkileri güncellenemedi: ${e.toString()}"));
    }
  }
}
