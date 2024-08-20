import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/local_storage/i_local_storage.dart';

class SharedPreferencesLocalStorage implements ILocalStorage {
  late SharedPreferences pref;

  SharedPreferencesLocalStorage() {
    init();
  }
  @override
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> containsKey(String key) async {
    return pref.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    await pref.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    await pref.clear();
  }

  @override
  Future<String?> read(String key) async {
    return pref.getString(key);
  }

  @override
  Future<List<Map<String, String>>> readAll() async {
    final keys = pref.getKeys();

    final prefMap = <String, dynamic>{};
    for (String key in keys) {
      prefMap[key] = pref.get(key);
    }
    return prefMap.entries
        .map((e) => Map.fromEntries([MapEntry(e.key, e.value.toString())]))
        .toList();
  }

  @override
  Future<void> save(String key, String value) async {
    await pref.setString(key, value);
  }
}
