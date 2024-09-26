import 'package:flutter/foundation.dart';

import '../../lookups/models/lookup.dart';
import '../models/user_group.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class UserGroupCubit extends BaseCubit<UserGroup> {
  UserGroupCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userGroupService;
  }

  Future<void> getSelectedUserGroupsByUserId(int userId) async {
    emit(BlocLoading("Kullanıcı grupları getiriliyor..."));
    try {
      final groups = await BusinessInitializer()
          .businessContainer
          .lookupService
          .getGroupLookUp();

      var selectedGroups = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .getUserGroupsByUserId(userId);

      var selectedGroupIds =
          selectedGroups.data!.map((group) => group.id).toSet();

      List<LookUp> updatedGroups = groups.map((group) {
        return LookUp(
          id: group.id,
          label: group.label,
          isSelected: selectedGroupIds.contains(group.id),
        );
      }).toList();

      emit(BlocSuccess<List<LookUp>>(updatedGroups));
    } catch (e) {
      emit(BlocFailed("Kullanıcı grupları getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> getSelectedGroupUsers(int groupId) async {
    try {
      final users = await BusinessInitializer()
          .businessContainer
          .lookupService
          .getUserLookUp();

      final selectedUsers = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .getGroupUsers(groupId);

      var selectedUserIds = selectedUsers.data!.map((user) => user.id).toSet();

      List<LookUp> updatedUsers = users.map((user) {
        return LookUp(
          id: user.id,
          label: user.label,
          isSelected: selectedUserIds.contains(user.id),
        );
      }).toList();

      emit(BlocSuccess<List<LookUp>>(updatedUsers));
    } catch (e) {
      emit(BlocFailed("Kullanıcılar getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveGroupUsers(int groupId, List<int> userIds) async {
    try {
      emit(BlocSending("Veri Ekleniyor"));
      await BusinessInitializer()
          .businessContainer
          .userGroupService
          .saveGroupUsers(groupId, userIds);
      getAll();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(BlocFailed(e.toString()));
    }
  }
}
