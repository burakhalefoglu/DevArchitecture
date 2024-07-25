import '../../di/core_initializer.dart';

abstract class IHttpInterceptor {
  Future<Map<String, dynamic>> interceptJson();
  Future<Map<String, dynamic>> interceptXml();
}

class HttpInterceptor implements IHttpInterceptor {
  @override
  Future<Map<String, dynamic>> interceptJson() async {
    return {
      "content-type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "Bearer ${await CoreInitializer().coreContainer.storage.read("token")}"
    };
  }

  @override
  Future<Map<String, dynamic>> interceptXml() async {
    return {
      "content-type": "application/xml",
      "Accept": "application/xml",
      "Authorization":
          "Bearer ${await CoreInitializer().coreContainer.storage.read("token")}"
    };
  }
}
