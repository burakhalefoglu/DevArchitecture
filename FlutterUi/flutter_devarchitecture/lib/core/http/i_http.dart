abstract class IHttp {
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<void> put(String url, Map<String, dynamic> body);
  Future<void> delete(String url);
}
