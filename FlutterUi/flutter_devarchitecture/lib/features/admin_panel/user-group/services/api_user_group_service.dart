import '../../../../core/di/core_initializer.dart';
import '../../../../core/services/base_services/api_service.dart';
import '../../../../core/utilities/results.dart';
import '../../../../core/models/lookup.dart';
import '../models/user_group.dart';
import 'i_user_group_service.dart';

class ApiUserGroupService extends ApiService<UserGroup>
    implements IUserGroupService {
  ApiUserGroupService({required super.method});

  @override
  Future<IDataResult<List<LookUp>>> getUserGroupsByUserId(int userId) async {
    var result =
        await CoreInitializer().coreContainer.http.get("$url/users/$userId");
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(
        SuccessDataResult(data.map((e) => LookUp.fromMap(e)).toList(), ""));
  }
}
