import '/features/admin_panel/lookups/models/lookup.dart';

import '../../../../core/services/i_service.dart';
import '../../../../core/utilities/results.dart';

abstract class IUserClaimService implements IService {
  Future<IDataResult<List<LookUp>>> getUserClaimsByUserId(int userId);
}
