import '../../lookups/models/lookup.dart';
import '../models/user_claim.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class UserClaimCubit extends BaseCubit<UserClaim> {
  UserClaimCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userClaimService;
  }

  Future<void> getUserClaimsByUserId(int userId) async {
    emit(BlocLoading("Kullanıcı yetkileri getiriliyor..."));
    try {
      final userClaims = await BusinessInitializer()
          .businessContainer
          .lookupService
          .getOperationClaimLookUp();

      final selectedUserClaimsResult = await BusinessInitializer()
          .businessContainer
          .userClaimService
          .getUserClaimsByUserId(userId);

      if (!selectedUserClaimsResult.isSuccess) {
        emitFailState(selectedUserClaimsResult.message);
        return;
      }
      var selectedClaimIds =
          selectedUserClaimsResult.data!.map((claim) => claim.id).toSet();

      List<LookUp> updatedClaims = userClaims.map((claim) {
        return LookUp(
          id: claim.id,
          label: claim.label,
          isSelected: selectedClaimIds.contains(claim.id),
        );
      }).toList();

      emit(BlocSuccess<List<LookUp>>(updatedClaims));
    } on Exception catch (e) {
      emitFailState("", e: e);
    }
  }

  Future<void> saveUserClaimsByUserId(int userId, List<int> claims) async {
    emit(BlocLoading("Kullanıcı yetkileri kaydediliyor..."));
    try {
      // yetkileri güncelle
      var result =
          await service.update(userId, {"UserId": userId, "ClaimIds": claims});

      if (!result.isSuccess) {
        emitFailState(result.message);
        return;
      }
      await getUserClaimsByUserId(userId); // Kullanıcıları tekrar yükleyin
    } on Exception catch (e) {
      emitFailState("", e: e);
    }
  }
}
