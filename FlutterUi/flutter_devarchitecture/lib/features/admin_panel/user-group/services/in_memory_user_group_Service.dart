import 'package:flutter_devarchitecture/core/utilities/results.dart';

import 'package:flutter_devarchitecture/core/models/lookup.dart';

import '../../../../core/services/base_services/in_memory_service.dart';
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
  Future<IDataResult<List<LookUp>>> getUserGroupsByUserId(int userId) async {
    return SuccessDataResult(
      _groups
          .where((element) => element.userId == userId)
          .map((e) => LookUp.fromMap(e.toMap()))
          .toList(),
      "",
    );
  }
}
