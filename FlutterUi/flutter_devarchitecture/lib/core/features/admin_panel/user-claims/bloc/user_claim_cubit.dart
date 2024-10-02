import '../../lookups/models/lookup.dart';
import '../models/user_claim.dart';
import '../../../../bloc/base_cubit.dart';
import '../../../../bloc/base_state.dart';
import '../../../../../di/business_initializer.dart';

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

      final selectedUserClaims = await BusinessInitializer()
          .businessContainer
          .userClaimService
          .getUserClaimsByUserId(userId);

      var selectedClaimIds =
          selectedUserClaims.data!.map((claim) => claim.id).toSet();

      List<LookUp> updatedClaims = userClaims.map((claim) {
        return LookUp(
          id: claim.id,
          label: claim.label,
          isSelected: selectedClaimIds.contains(claim.id),
        );
      }).toList();

      emit(BlocSuccess<List<LookUp>>(updatedClaims));
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserClaimsByUserId(int userId, List<int> claims) async {
    emit(BlocLoading("Kullanıcı yetkileri kaydediliyor..."));
    try {
      // yetkileri güncelle
      await service.update(userId, {"UserId": userId, "ClaimIds": claims});
      await getUserClaimsByUserId(userId); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri kaydedilemedi: ${e.toString()}"));
    }
  }
}