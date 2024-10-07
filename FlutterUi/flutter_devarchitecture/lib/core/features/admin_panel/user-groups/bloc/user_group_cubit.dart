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

      var selectedGroups = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .getUserGroupPermissions(userId);

      if (!selectedGroups.isSuccess) {
        emitFailState(message: selectedGroups.message);
        return;
      }

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
      print(updatedGroups.map((e) => e.toMap()).toList());
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> saveUserGroupPermissions(int userId, List<int> groups) async {
    emit(BlocLoading("Kullanıcı grupları kaydediliyor..."));
    try {
      var result = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .saveUserGroupPermissions(userId, groups);

      if (!result.isSuccess) {
        emitFailState(message: result.message);
        return;
      }
      await getUserGroupPermissions(userId); // Verileri tekrar yükleyin
    } on Exception catch (e) {
      emitFailState(e: e);
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

      if (!selectedUsers.isSuccess) {
        emitFailState(message: selectedUsers.message);
        return;
      }

      var selectedUserIds = selectedUsers.data!.map((user) => user.id).toSet();

      List<LookUp> updatedUsers = users.map((user) {
        return LookUp(
          id: user.id,
          label: user.label,
          isSelected: selectedUserIds.contains(user.id),
        );
      }).toList();

      emit(BlocSuccess<List<LookUp>>(updatedUsers));
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> saveGroupUsers(int groupId, List<int> userIds) async {
    try {
      emit(BlocSending("Veri Ekleniyor"));
      var result = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .saveGroupUsers(groupId, userIds);

      if (!result.isSuccess) {
        emitFailState(message: result.message);
        return;
      }
      await getGroupUsers(groupId);
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }
}
