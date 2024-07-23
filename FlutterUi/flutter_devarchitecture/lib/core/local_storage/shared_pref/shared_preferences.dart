import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/local_storage/i_local_storage.dart';

class SharedPreferencesLocalStorage implements ILocalStorage {
  static final SharedPreferencesLocalStorage _singleton =
      SharedPreferencesLocalStorage._internal();

  factory SharedPreferencesLocalStorage() {
    return _singleton;
  }
  SharedPreferencesLocalStorage._internal();

  @override
  Future<void> init() async {}

  @override
  Future<bool> containsKey(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Future<String?> read(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  @override
  Future<List<Map<String, String>>> readAll() async {
    final pref = await SharedPreferences.getInstance();
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
    var pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }
}
