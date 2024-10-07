import '../models/operation_claim.dart';
import '../../../../bloc/base_cubit.dart';
import '../../../../bloc/base_state.dart';
import '../../../../../di/business_initializer.dart';
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
        emitFailState(message: result.message);
        return;
      }
      await getAll();
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }
}
