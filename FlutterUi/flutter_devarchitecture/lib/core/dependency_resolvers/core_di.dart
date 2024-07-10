import '../../core/http/http_interceptor.dart';
import '../cross_cutting_concerns/screen_message.dart';
import '../local_storage/i_local_storage.dart';
import '../http/i_http.dart';

abstract class ICoreContainer {
  late IHttp http;
  late ILocalStorage storage;
  late IScreenMessage screenMessage;
  late IHttpInterceptor httpInterceptor;
  setUp();
  void checkIfUnRegistered<T extends Object>(Function register);
}
