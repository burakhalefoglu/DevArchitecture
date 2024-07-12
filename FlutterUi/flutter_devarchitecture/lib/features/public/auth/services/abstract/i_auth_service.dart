import '../../../../../core/cross_cutting_concerns/results.dart';
import '../../../../../core/services/i_service.dart';
import '../../models/auth.dart';

abstract class IAuthService implements IService {
  Future<IDataResult<AuthResponse>> login(String email, String password);
}
