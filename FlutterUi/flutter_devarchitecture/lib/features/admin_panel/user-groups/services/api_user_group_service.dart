import '../../../../core/di/core_initializer.dart';
import '../../../../core/services/base_services/api_service.dart';
import '../../../../core/utilities/results.dart';
import '../../lookups/models/lookup.dart';
import '../models/user_group.dart';
import 'i_user_group_service.dart';

class ApiUserGroupService extends ApiService<UserGroup>
    implements IUserGroupService {
  ApiUserGroupService({required super.method});

  @override
  Future<IDataResult<List<LookUp>>> getUserGroupPermissions(int userId) async {
    var result = await CoreInitializer()
        .coreContainer
        .http
        .get("$url/users/$userId/groups");
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(
        SuccessDataResult(data.map((e) => LookUp.fromMap(e)).toList(), ""));
  }

  @override
  Future<void> saveUserGroupPermissions(int userId, List<int> groups) async {
    await CoreInitializer()
        .coreContainer
        .http
        .put("$url", {"UserId": userId, "GroupId": groups});
    return Future.value(SuccessResult("Veri Güncellendi !"));
  }

  @override
  Future<IDataResult<List<LookUp>>> getGroupUsers(int groupId) async {
    var result = await CoreInitializer()
        .coreContainer
        .http
        .get("$url/groups/${groupId}/users");
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(
        SuccessDataResult(data.map((e) => LookUp.fromMap(e)).toList(), ""));
  }

  @override
  Future<void> saveGroupUsers(int groupId, List<int> userIds) async {
    await CoreInitializer()
        .coreContainer
        .http
        .put("$url/groups/", {"GroupId": groupId, "UserIds": userIds});
    return Future.value(SuccessResult("Veri Güncellendi !"));
  }
}
