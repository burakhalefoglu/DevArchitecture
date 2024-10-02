import 'package:flutter/foundation.dart';

import '../../lookups/models/lookup.dart';
import '../models/user_group.dart';
import '../../../../bloc/base_cubit.dart';
import '../../../../bloc/base_state.dart';
import '../../../../../di/business_initializer.dart';

class UserGroupCubit extends BaseCubit<UserGroup> {
  UserGroupCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userGroupService;
  }

  Future<void> getUserGroupPermissions(int userId) async {
    emit(BlocLoading("Kullanıcı grupları getiriliyor..."));
    try {
      final groups = await BusinessInitializer()
          .businessContainer
          .lookupService
          .getGroupLookUp();
      print(groups.map((e) => e.toMap()).toList());
      var selectedGroups = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .getUserGroupPermissions(userId);
      print(selectedGroups.data!.map((e) => e.toMap()).toList());

      var selectedGroupIds =
          selectedGroups.data!.map((group) => group.id).toSet();
      print(selectedGroupIds.toList());

      List<LookUp> updatedGroups = groups.map((group) {
        return LookUp(
          id: group.id,
          label: group.label,
          isSelected: selectedGroupIds.contains(group.id),
        );
      }).toList();
      emit(BlocSuccess<List<LookUp>>(updatedGroups));
      print(updatedGroups.map((e) => e.toMap()).toList());
    } catch (e) {
      emit(BlocFailed("Kullanıcı grupları getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserGroupPermissions(int userId, List<int> groups) async {
    emit(BlocLoading("Kullanıcı grupları kaydediliyor..."));
    try {
      // yetkileri güncelle
      await BusinessInitializer()
          .businessContainer
          .userGroupService
          .saveUserGroupPermissions(userId, groups);
      await getUserGroupPermissions(userId); // Verileri tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri kaydedilemedi: ${e.toString()}"));
    }
  }

  Future<void> getGroupUsers(int groupId) async {
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
      await getGroupUsers(groupId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(BlocFailed(e.toString()));
    }
  }
}
