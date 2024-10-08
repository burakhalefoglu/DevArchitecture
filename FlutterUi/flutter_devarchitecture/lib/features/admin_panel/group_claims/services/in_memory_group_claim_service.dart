import 'package:flutter_devarchitecture/core/utilities/results.dart';

import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

import '../../../../core/services/base_services/in_memory_service.dart';
import '../models/group_claim.dart';
import 'i_group_claim_service.dart';

class InMemoryGroupClaimService extends InMemoryService<GroupClaim>
    implements IGroupClaimService {
  List<GroupClaim> _groupclaim = [GroupClaim(id: 1, groupId: 1, claimId: 1)];
  InMemoryGroupClaimService() {
    super.datas = _groupclaim.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<LookUp>>> getGroupClaimsByGroupId(int groupId) async {
    return SuccessDataResult(
        _groupclaim
            .where((element) => element.groupId == groupId)
            .map((e) => LookUp.fromMap(e.toMap()))
            .toList(),
        "");
  }
}
