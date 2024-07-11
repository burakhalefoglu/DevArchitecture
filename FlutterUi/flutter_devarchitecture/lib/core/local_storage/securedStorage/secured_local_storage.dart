import '../../../core/local_storage/i_local_storage.dart';

//TODO: Fill it
class SecuredLocalStorage implements ILocalStorage {
  @override
  Future<bool> containsKey(String key) {
    return Future.value(true);
  }

  @override
  Future<void> delete(String key) async {
    Future.delayed(Duration.zero);
  }

  @override
  Future<void> deleteAll() async {
    Future.delayed(Duration.zero);
  }

  @override
  Future<String?> read(String key) {
    return Future.value("");
  }

  @override
  Future<List<Map<String, String>>> readAll() {
    return Future.value([]);
  }

  @override
  Future<void> save(String key, String value) async {
    Future.delayed(Duration.zero);
  }

  @override
  init() {}
}
