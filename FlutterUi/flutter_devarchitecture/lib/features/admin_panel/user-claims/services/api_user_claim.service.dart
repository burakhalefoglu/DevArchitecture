import 'package:flutter_devarchitecture/features/admin_panel/user-claims/models/lookup.dart';

import '../../../../core/di/core_initializer.dart';
import '../../../../core/services/base_services/api_service.dart';
import '../../../../core/utilities/results.dart';
import '../models/user_claim.dart';
import 'i_user_claim_service.dart';

class ApiUserClaimService extends ApiService<UserClaim>
    implements IUserClaimService {
  ApiUserClaimService({required super.method});

  @override
  Future<IDataResult<List<LookUp>>> getUserClaimsByUserId(int userId) async {
    var result =
        await CoreInitializer().coreContainer.http.get("$url/users/$userId");
    var data = result["data"] as List<Map<String, dynamic>>;
    return Future.value(
        SuccessDataResult(data.map((e) => LookUp.fromMap(e)).toList(), ""));
  }
}
