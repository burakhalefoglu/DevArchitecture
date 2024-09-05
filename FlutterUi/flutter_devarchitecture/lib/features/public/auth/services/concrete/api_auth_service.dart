import '../../../../../core/utilities/results.dart';
import '../../../../../core/di/core_initializer.dart';
import '../../../../../core/services/base_services/api_service.dart';
import '../../models/auth.dart';
import '../abstract/i_auth_service.dart';

class ApiAuthService extends ApiService<AuthRequestBasic>
    implements IAuthService {
  ApiAuthService({required super.method});

  @override
  Future<IDataResult<AuthResponse>> login(
      String username, String password) async {
    var result = await CoreInitializer()
        .coreContainer
        .http
        .post("$url/login", {'email': username, 'password': password});
    return SuccessDataResult(
        AuthResponse(
          token: result["data"]["token"],
          refreshToken: result["data"]["refreshToken"],
          claims: result["data"]["claims"],
          expiration: DateTime.parse(result["data"]["expiration"]),
        ),
        result["message"]);
  }
}
