import 'package:flutter_devarchitecture/core/features/admin_panel/lookups/models/lookup.dart';

import '../../../../bloc/base_cubit.dart';
import '../../../../bloc/base_state.dart';
import '../../../../../di/business_initializer.dart';
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

      final selectedGroupClaimResult = await BusinessInitializer()
          .businessContainer
          .groupClaimService
          .getGroupClaimsByGroupId(groupId);
      if (!selectedGroupClaimResult.isSuccess) {
        emitFailState(message: selectedGroupClaimResult.message);
        return;
      }
      var selectedClaimIds =
          selectedGroupClaimResult.data!.map((claim) => claim.id).toSet();

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
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> saveGroupClaimsByGroupId(int groupId, List<int> claims) async {
    emit(BlocLoading("Grup yetkisi güncelleniyor..."));
    try {
      var result = await BusinessInitializer()
          .businessContainer
          .groupClaimService
          .update(groupId, {'GroupId': groupId, 'ClaimIds': claims});
      if (result.isSuccess == false) {
        emitFailState(message: result.message);
        return;
      }
      await getGroupClaimsByGroupId(groupId);
      emit(BlocSuccess("Grup yetkisi güncellendi"));
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }
}
