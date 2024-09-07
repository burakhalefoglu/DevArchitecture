import '../../../../core/services/i_service.dart';
import '../../../../core/utilities/results.dart';
import '../../../../core/models/lookup.dart';

abstract class IUserGroupService implements IService {
  Future<IDataResult<List<LookUp>>> getUserGroupsByUserId(int userId);
}
