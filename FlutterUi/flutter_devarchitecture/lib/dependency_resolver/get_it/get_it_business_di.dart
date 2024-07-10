import 'package:get_it/get_it.dart';
import '../../../core/configs/app_config.dart';
import '../../core/widgets/charts/geekyants_gauges_chart.dart';
import '../../core/widgets/charts/i_chart.dart';
import '../../core/widgets/inputs/address_input/google_autocomplete.dart';
import '../../core/widgets/inputs/address_input/i_address_input.dart';
import '../../core/widgets/tables/data_table_2.dart';
import '../../core/widgets/tables/i_tables.dart';
import '../../features/auth/services/abstract/i_auth_service.dart';
import '../../features/auth/services/concrete/api_auth_service.dart';
import '../../features/auth/services/concrete/in_memory_auth_service.dart';
import '../business_container.dart';

class GetItBusinessContainer implements IBusinessContainer {
  late GetIt _getIt;
  void _init() {
    _getIt = GetIt.instance;
    setup();
  }

  GetItBusinessContainer() {
    _init();
  }

  @override
  late IAddressInput addressInput;

  @override
  late ITables dataTable;

  @override
  late IGaugesChart gaugesChart;

  @override
  late ILoaderChart loaderChart;

  @override
  late IAuthService authService;
  @override
  void setup() {
    //*? Widgets Binding

    checkIfUnRegistered<ITables>((() {
      dataTable = _getIt.registerSingleton<ITables>(DataTables());
    }));
    checkIfUnRegistered<IGaugesChart>((() {
      gaugesChart =
          _getIt.registerSingleton<IGaugesChart>(GeekyantsGaugesChart());
    }));
    checkIfUnRegistered<IAddressInput>((() {
      addressInput =
          _getIt.registerSingleton<IAddressInput>(GoogleAutoComplete());
    }));

    //*? Services Binding For DEVELOPMENT
    if (appConfig.name == 'dev' || appConfig.name == '') {
      checkIfUnRegistered<IAuthService>((() {
        authService =
            _getIt.registerSingleton<IAuthService>(InMemoryAuthService());
      }));
    }

    //*? Services Binding For STAGING
    if (appConfig.name == 'staging') {
      checkIfUnRegistered<IAuthService>((() {
        authService = _getIt
            .registerSingleton<IAuthService>(ApiAuthService(method: "/Auth"));
      }));
    }

    //*? Services Binding For PRODUCTION
    if (appConfig.name == 'prod') {
      checkIfUnRegistered<IAuthService>((() {
        authService = _getIt
            .registerSingleton<IAuthService>(ApiAuthService(method: "/Auth"));
      }));
    }
  }

  @override
  void checkIfUnRegistered<T extends Object>(Function register) {
    if (!_getIt.isRegistered<T>()) {
      register.call();
    }
  }
}
