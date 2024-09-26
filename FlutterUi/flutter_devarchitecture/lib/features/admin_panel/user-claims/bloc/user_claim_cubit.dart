import '../../lookups/models/lookup.dart';
import '/features/admin_panel/user-claims/models/user_claim.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class UserClaimCubit extends BaseCubit<UserClaim> {
  UserClaimCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userClaimService;
  }

  Future<void> getSelectedUserClaimsByUserId(int userId) async {
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
}
