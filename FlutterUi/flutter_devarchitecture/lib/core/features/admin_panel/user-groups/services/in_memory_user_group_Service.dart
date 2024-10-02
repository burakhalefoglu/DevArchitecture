import 'package:flutter_devarchitecture/core/utilities/results.dart';

import 'package:flutter_devarchitecture/core/features/admin_panel/lookups/models/lookup.dart';

import '../../../../services/base_services/in_memory_service.dart';
import '../models/user_group.dart';
import 'i_user_group_service.dart';

class InMemoryUserGroupService extends InMemoryService<UserGroup>
    implements IUserGroupService {
  List<UserGroup> _groups = [
    UserGroup(id: 1, groupId: 1, userId: 1),
    UserGroup(id: 1, groupId: 2, userId: 1),
  ];

  InMemoryUserGroupService() {
    super.datas = _groups.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<LookUp>>> getUserGroupPermissions(int userId) async {
    return SuccessDataResult(
      _groups
          .where((element) => element.userId == userId)
          .map((e) => LookUp.fromMap(e.toMap()))
          .toList(),
      "",
    );
  }

  @override
  Future<IDataResult<List<LookUp>>> getGroupUsers(int groupId) async {
    return SuccessDataResult(
      _groups
          .where((element) => element.groupId == groupId)
          .map((e) => LookUp.fromMap(e.toMap()))
          .toList(),
      "",
    );
  }

  @override
  Future<void> saveGroupUsers(int groupId, List<int> userIds) async {
    for (var userId in userIds) {
      List<UserGroup> userGroups =
          _groups.where((element) => element.userId == userId).toList();
      for (var group in userGroups) {
        group.groupId = groupId;
      }
    }
  }

  @override
  Future<void> saveUserGroupPermissions(int userId, List<int> groups) async {
    Future.value();
  }
}
