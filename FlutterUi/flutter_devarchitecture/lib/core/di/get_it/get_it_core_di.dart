import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter_devarchitecture/core/utilities/permission_handler/i_permission_handler.dart';
import 'package:flutter_devarchitecture/core/utilities/permission_handler/permission_handler.dart';
import '../../utilities/battery_state_management/battery_state_plus.dart';
import '../../utilities/battery_state_management/i_battery_state.dart';
import '/core/local_storage/securedStorage/secured_local_storage.dart';
import '/core/utilities/internet_connection/internet_connection_checker.dart';
import '../../utilities/device_information_management/device_info_plus.dart';
import '../../utilities/device_information_management/i_device_information.dart';
import '/core/utilities/message_broker/i_message_broker.dart';
import '/core/utilities/notification/i_notification_service.dart';
import '/core/utilities/notification/local_notification_service.dart';
import '/core/widgets/animations/i_animation_asset.dart';
import '/core/widgets/animations/lottie_animation_asset.dart';
import '/core/widgets/charts/graphic/graphic_analytics_chart.dart';
import '/core/widgets/charts/graphic/graphic_basic_chart.dart';
import '/core/widgets/charts/graphic/graphic_event_chart.dart';
import 'package:get_it/get_it.dart';
import '../../utilities/internet_connection/i_internet_connection.dart';
import '../../utilities/message_broker/rabbitmq_broker.dart';
import '../../utilities/screen_message.dart';
import '../../utilities/http/dart_io_http.dart';
import '../../utilities/http/http_interceptor.dart';
import '../../utilities/http/i_http.dart';
import '../../local_storage/i_local_storage.dart';
import '../../widgets/charts/geekyants/geekyants_gauges_chart.dart';
import '../../widgets/charts/i_chart.dart';
import '../../widgets/inputs/address_input/google_autocomplete.dart';
import '../../widgets/inputs/address_input/i_address_input.dart';
import '../../widgets/tables/data_table/data_table_2.dart';
import '../../widgets/tables/i_tables.dart';
import '../i_core_container.dart';

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
  late IAnimationAsset animationAsset;

  @override
  late IHttp http;

  @override
  late IScreenMessage screenMessage;

  @override
  late ILocalStorage storage;

  @override
  late IHttpInterceptor httpInterceptor;

  @override
  late IBasicChart basicChart;

  @override
  late IAnalyticsChart analyticsChart;

  @override
  late IEventStreamChart eventStreamChart;

  @override
  late IAddressInput addressInput;

  @override
  late ITables dataTable;

  @override
  late IGaugesChart gaugesChart;

  @override
  late IDeviceInformation deviceInformation;

  @override
  late INotificationService notificationService;

  @override
  late IMessageBroker messageBroker;

  @override
  late IInternetConnection internetConnection;

  @override
  late IBatteryState batteryState;

  @override
  late IPermissionHandler permissionHandler;

  @override
  setUp() {
    checkIfUnRegistered<ITables>((() {
      dataTable = _getIt.registerSingleton<ITables>(DataTables());
    }));
    checkIfUnRegistered<IAddressInput>((() {
      addressInput =
          _getIt.registerSingleton<IAddressInput>(GoogleAutoComplete());
    }));

    checkIfUnRegistered<IAnimationAsset>((() {
      animationAsset =
          _getIt.registerSingleton<IAnimationAsset>(LottieAnimationAsset());
    }));
    checkIfUnRegistered<IScreenMessage>((() {
      screenMessage =
          _getIt.registerSingleton<IScreenMessage>(OkToastScreenMessage());
    }));
    checkIfUnRegistered<ILocalStorage>((() {
      storage = _getIt.registerSingleton<ILocalStorage>(SecuredLocalStorage());
    }));
    checkIfUnRegistered<IHttpInterceptor>((() {
      httpInterceptor =
          _getIt.registerSingleton<IHttpInterceptor>(HttpInterceptor());
    }));
    checkIfUnRegistered<IHttp>((() {
      http = _getIt.registerSingleton<IHttp>(HttpDartIo(httpInterceptor));
    }));

    // charts
    checkIfUnRegistered<IBasicChart>((() {
      basicChart = _getIt.registerSingleton<IBasicChart>(GraphicBasicChart());
    }));
    checkIfUnRegistered<IAnalyticsChart>((() {
      analyticsChart =
          _getIt.registerSingleton<IAnalyticsChart>(GraphicAnalyticsChart());
    }));
    checkIfUnRegistered<IEventStreamChart>((() {
      eventStreamChart = _getIt
          .registerSingleton<IEventStreamChart>(GraphicEventStreamChart());
    }));
    checkIfUnRegistered<IGaugesChart>((() {
      gaugesChart =
          _getIt.registerSingleton<IGaugesChart>(GeekyantsGaugesChart());
    }));

    checkIfUnRegistered<IDeviceInformation>((() {
      deviceInformation =
          _getIt.registerSingleton<IDeviceInformation>(DeviceInfoPlus());
    }));

    checkIfUnRegistered<INotificationService>((() {
      notificationService = _getIt.registerSingleton<INotificationService>(
          LocalNotificationService.init());
    }));

    checkIfUnRegistered<IMessageBroker>((() {
      messageBroker =
          _getIt.registerSingleton<IMessageBroker>(RabbitMQMessageBroker(
              "default_queue",
              ConnectionSettings(
                host: "localhost",
                authProvider: PlainAuthenticator("guest", "guest"),
              )));
    }));

    checkIfUnRegistered<IInternetConnection>((() {
      internetConnection = _getIt.registerSingleton<IInternetConnection>(
          InternetConnectionWithChecker());
    }));

    checkIfUnRegistered<IBatteryState>((() {
      batteryState =
          _getIt.registerSingleton<IBatteryState>(BatteryStateBatteryPlus());
    }));

    checkIfUnRegistered<IPermissionHandler>((() {
      permissionHandler =
          _getIt.registerSingleton<IPermissionHandler>(PermissionHandler());
    }));
  }

  @override
  void checkIfUnRegistered<T extends Object>(Function register) {
    if (!_getIt.isRegistered<T>()) {
      register.call();
    }
  }
}
