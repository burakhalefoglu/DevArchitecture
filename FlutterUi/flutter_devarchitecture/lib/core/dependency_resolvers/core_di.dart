import '../../core/http/http_interceptor.dart';
import '../cross_cutting_concerns/screen_message.dart';
import '../local_storage/i_local_storage.dart';
import '../http/i_http.dart';
import '../widgets/animations/i_animation_asset.dart';
import '../widgets/charts/i_chart.dart';
import '../widgets/inputs/address_input/i_address_input.dart';
import '../widgets/tables/i_tables.dart';

abstract class ICoreContainer {
  late IHttp http;
  late ILocalStorage storage;
  late IHttpInterceptor httpInterceptor;

  late IAnimationAsset animationAsset;
  late IAddressInput addressInput;
  late ITables dataTable;
  late IScreenMessage screenMessage;

  // charts
  late IBasicChart basicChart;
  late IGaugesChart gaugesChart;
  late IAnalyticsChart analyticsChart;
  late IEventStreamChart eventStreamChart;

  setUp();
  void checkIfUnRegistered<T extends Object>(Function register);
}
