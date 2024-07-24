import '../utilities/battery_state_management/i_battery_state.dart';
import '../utilities/internet_connection/i_internet_connection.dart';
import '../utilities/device_information_management/i_device_information.dart';
import '../utilities/http/http_interceptor.dart';
import '../utilities/message_broker/i_message_broker.dart';
import '../utilities/notification/i_notification_service.dart';
import '../utilities/screen_message.dart';
import '../utilities/permission_handler/i_permission_handler.dart';
import '../local_storage/i_local_storage.dart';
import '../utilities/http/i_http.dart';
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

  // utilities
  late IDeviceInformation deviceInformation;
  late INotificationService notificationService;
  late IMessageBroker messageBroker;
  late IInternetConnection internetConnection;
  late IBatteryState batteryState;
  late IPermissionHandler permissionHandler;

  setUp();
  void checkIfUnRegistered<T extends Object>(Function register);
}
