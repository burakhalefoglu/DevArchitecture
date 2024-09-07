import 'package:flutter_devarchitecture/core/models/lookup.dart';

import '../../../../core/services/i_service.dart';
import '../../../../core/utilities/results.dart';

abstract class IUserClaimService implements IService {
  Future<IDataResult<List<LookUp>>> getUserClaimsByUserId(int userId);
}
