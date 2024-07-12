import '../../core/widgets/tables/i_tables.dart';
import '../../core/widgets/inputs/address_input/i_address_input.dart';
import '../../core/widgets/charts/i_chart.dart';
import '../features/public/auth/services/abstract/i_auth_service.dart';

abstract class IBusinessContainer {
  late ITables dataTable;
  late IGaugesChart gaugesChart;
  late ILoaderChart loaderChart;
  late IAddressInput addressInput;

  late IAuthService authService;

  void setup();
  void checkIfUnRegistered<T extends Object>(Function register);
}
