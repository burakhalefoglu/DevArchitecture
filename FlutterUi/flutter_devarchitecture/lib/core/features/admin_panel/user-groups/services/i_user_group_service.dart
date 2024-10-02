import '../../../../services/i_service.dart';
import '../../../../utilities/results.dart';
import '../../lookups/models/lookup.dart';

abstract class IUserGroupService implements IService {
  Future<IDataResult<List<LookUp>>> getUserGroupPermissions(int userId);
  Future<IDataResult<List<LookUp>>> getGroupUsers(int groupId);
  Future<void> saveGroupUsers(int groupId, List<int> userIds);
  Future<void> saveUserGroupPermissions(int userId, List<int> groups);
}
