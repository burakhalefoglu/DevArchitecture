import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/local_storage/i_local_storage.dart';

class SecuredLocalStorage implements ILocalStorage {
  static final SecuredLocalStorage _singleton = SecuredLocalStorage._internal();

  factory SecuredLocalStorage() {
    return _singleton;
  }
  SecuredLocalStorage._internal();

  late FlutterSecureStorage storage;
  IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  init() async {
    storage = FlutterSecureStorage(
        aOptions: _getAndroidOptions(), iOptions: _getIosOptions());
  }

  @override
  Future<bool> containsKey(String key) async {
    var result = await storage.containsKey(key: key);
    return result;
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<List<Map<String, String>>> readAll() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues.entries
        .map((e) => Map.fromEntries([MapEntry(e.key, e.value.toString())]))
        .toList();
  }

  @override
  Future<void> save(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
