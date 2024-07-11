import 'package:get_it/get_it.dart';
import '../../cross_cutting_concerns/screen_message.dart';
import '../../http/dart_io_http.dart';
import '../../http/http_interceptor.dart';
import '../../http/i_http.dart';
import '../../local_storage/i_local_storage.dart';
import '../../local_storage/shared_pref/shared_preferences.dart';
import '../core_di.dart';

class GetItCoreContainer implements ICoreContainer {
  late GetIt _getIt;
  void init() {
    _getIt = GetIt.instance;
    setUp();
  }

  GetItCoreContainer() {
    init();
  }

  @override
  late IHttp http;

  @override
  late IScreenMessage screenMessage;

  @override
  late ILocalStorage storage;

  @override
  late IHttpInterceptor httpInterceptor;

  @override
  setUp() {
    checkIfUnRegistered<IScreenMessage>((() {
      screenMessage =
          _getIt.registerSingleton<IScreenMessage>(OkToastScreenMessage());
    }));
    checkIfUnRegistered<ILocalStorage>((() {
      storage = _getIt
          .registerSingleton<ILocalStorage>(SharedPreferencesLocalStorage());
    }));
    checkIfUnRegistered<IHttpInterceptor>((() {
      httpInterceptor =
          _getIt.registerSingleton<IHttpInterceptor>(HttpInterceptor());
    }));
    checkIfUnRegistered<IHttp>((() {
      http = _getIt.registerSingleton<IHttp>(HttpDartIo(httpInterceptor));
    }));
  }

  @override
  void checkIfUnRegistered<T extends Object>(Function register) {
    if (!_getIt.isRegistered<T>()) {
      register.call();
    }
  }
}
