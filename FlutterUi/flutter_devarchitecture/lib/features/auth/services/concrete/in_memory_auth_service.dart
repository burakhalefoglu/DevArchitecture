import '../../../../core/cross_cutting_concerns/results.dart';
import '../../../../core/services/base_services/in_memory_service.dart';
import '../../models/auth.dart';
import '../abstract/i_auth_service.dart';

class InMemoryAuthService extends InMemoryService<AuthRequestBasic>
    implements IAuthService {
  late List<Map<String, dynamic>> _authList;
  init() {
    _authList = [
      {
        'claims': [],
        'expiration': DateTime.now(),
        'token': "token",
        'refreshToken': "refreshToken",
        'id': 1,
        'name': 'admin@adminmail.com',
      },
    ];
  }

  InMemoryAuthService() : super() {
    init();
    super.datas = _authList;
  }

  @override
  Future<IDataResult<AuthResponse>> login(String username, String password) {
    var data = _authList.firstWhere((element) => element['name'] == username,
        orElse: () => {});
    if (data.isEmpty) {
      return Future.value(FailureDataResult("Kullanıcı Bulunamadı!"));
    }
    return Future.value(SuccessDataResult(
        AuthResponse(
            claims: [],
            expiration: DateTime.now(),
            token: "token",
            refreshToken: "refreshToken"),
        ""));
  }
}
