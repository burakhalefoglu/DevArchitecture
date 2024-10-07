import 'package:flutter_devarchitecture/core/features/admin_panel/lookups/models/lookup.dart';

import '../../../../configs/app_config.dart';
import '../../../../di/core_initializer.dart';
import 'i_lookup_service.dart';

class ApiLookupService implements ILookupService {
  late String url;

  init() {
    url = appConfig.apiUrl;
  }

  ApiLookupService() {
    init();
  }

  @override
  Future<List<LookUp>> getGroupLookUp() async {
    var result =
        await CoreInitializer().coreContainer.http.get(url + "/groups/lookups");
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();

    return Future.value(data.map((e) => LookUp.fromMap(e)).toList());
  }

  @override
  Future<List<LookUp>> getLanguageLookup() async {
    var result =
        await CoreInitializer().coreContainer.http.get(url + "/users/lookups");
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();
    return Future.value(data.map((e) => LookUp.fromMap(e)).toList());
  }

  @override
  Future<List<LookUp>> getOperationClaimLookUp() async {
    var result = await CoreInitializer()
        .coreContainer
        .http
        .get(url + "/operation-claims/lookups");
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();
    return Future.value(data.map((e) => LookUp.fromMap(e)).toList());
  }

  @override
  Future<List<LookUp>> getUserLookUp() async {
    var result =
        await CoreInitializer().coreContainer.http.get(url + "/users/lookups");
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();
    return Future.value(data.map((e) => LookUp.fromMap(e)).toList());
  }
}
