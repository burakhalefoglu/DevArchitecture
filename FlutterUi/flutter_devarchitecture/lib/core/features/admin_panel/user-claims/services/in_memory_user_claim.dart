import '../../../../services/base_services/in_memory_service.dart';
import '../../../../utilities/results.dart';
import '../../lookups/models/lookup.dart';
import '../models/user_claim.dart';
import 'i_user_claim_service.dart';

class InMemoryUserClaimService extends InMemoryService<UserClaim>
    implements IUserClaimService {
  List<UserClaim> _userClaims = [
    UserClaim(id: 1, userId: 1, claimId: 1),
  ];
  InMemoryUserClaimService() {
    super.datas = _userClaims.map((e) => e.toMap()).toList();
  }
  Future<List<UserClaim>> getAllUsers() async {
    return _userClaims;
  }

  Future<IDataResult<List<LookUp>>> getUserClaimsByUserId(int userId) async {
    return SuccessDataResult(
        _userClaims
            .where((element) => element.userId == userId)
            .map((e) => LookUp.fromMap(e.toMap()))
            .toList(),
        "");
  }
}
