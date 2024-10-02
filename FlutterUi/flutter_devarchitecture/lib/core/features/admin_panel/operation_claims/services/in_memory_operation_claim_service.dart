import '../../../../services/base_services/in_memory_service.dart';
import '../models/operation_claim.dart';
import 'i_operation_claim_service.dart';

class InMemoryOperationClaimService extends InMemoryService<OperationClaim>
    implements IOperationClaimService {
  List<OperationClaim> _operationClaim = [
    OperationClaim(
        id: 1,
        name: "GetUserLookupQuery",
        alias: "GetUserLookupQuery",
        description: "GetUserLookupQuery"),
    OperationClaim(
        id: 1,
        name: "GetUserQuery",
        alias: "GetUserQuery",
        description: "GetUserQuery"),
  ];

  InMemoryOperationClaimService() {
    super.datas = _operationClaim.map((e) => e.toMap()).toList();
  }
}
