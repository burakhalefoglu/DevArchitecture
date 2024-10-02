import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../models/group_claim.dart';

class GroupClaimCubit extends BaseCubit<GroupClaim> {
  GroupClaimCubit() : super() {
    super.service = BusinessInitializer().businessContainer.groupClaimService;
  }

  Future<void> getGroupClaimsByGroupId(int groupId) async {
    emit(BlocLoading("Grup yetkileri getiriliyor..."));
    try {
      final groupClaims = await BusinessInitializer()
          .businessContainer
          .lookupService
          .getOperationClaimLookUp();

      print("groupClaims: " +
          groupClaims.map((claim) => claim.toMap()).toList().toString());

      final selectedGroupClaims = await BusinessInitializer()
          .businessContainer
          .groupClaimService
          .getGroupClaimsByGroupId(groupId);

      var selectedClaimIds =
          selectedGroupClaims.data!.map((claim) => claim.id).toSet();

      List<LookUp> updatedClaims = groupClaims.map((claim) {
        return LookUp(
          id: claim.id,
          label: claim.label,
          isSelected: selectedClaimIds.contains(claim.id),
        );
      }).toList();
      print("updatedClaims: " +
          updatedClaims.map((e) => e.toMap()).toList().toString());
      emit(BlocSuccess<List<LookUp>>(updatedClaims));
    } catch (e) {
      emit(BlocFailed("Grup yetkileri getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveGroupClaimsByGroupId(int groupId, List<int> claims) async {
    emit(BlocLoading("Grup yetkisi güncelleniyor..."));
    try {
      await BusinessInitializer()
          .businessContainer
          .groupClaimService
          .update(groupId, {'GroupId': groupId, 'ClaimIds': claims});
      await getGroupClaimsByGroupId(groupId);
      emit(BlocSuccess("Grup yetkisi güncellendi"));
    } catch (e) {
      emit(BlocFailed("Grup yetkisi eklenemedi: ${e.toString()}"));
    }
  }
}
