import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

import 'i_lookup_service.dart';

class InMemoryLookupService implements ILookupService {
  @override
  Future<List<LookUp>> getGroupLookUp() async {
    return Future.value([]);
  }

  @override
  Future<List<LookUp>> getLanguageLookup() {
    return Future.value([]);
  }

  @override
  Future<List<LookUp>> getOperationClaimLookUp() {
    return Future.value([]);
  }

  @override
  Future<List<LookUp>> getUserLookUp() {
    return Future.value([]);
  }
}
