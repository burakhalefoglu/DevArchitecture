import 'package:flutter_devarchitecture/core/features/admin_panel/lookups/models/lookup.dart';

import '../../../../services/i_service.dart';
import '../../../../utilities/results.dart';

abstract class IUserClaimService implements IService {
  Future<IDataResult<List<LookUp>>> getUserClaimsByUserId(int userId);
}
