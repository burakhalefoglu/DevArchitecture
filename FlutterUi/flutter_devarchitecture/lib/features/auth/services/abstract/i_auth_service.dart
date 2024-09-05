import '../../../../core/utilities/results.dart';
import '../../../../core/services/i_service.dart';
import '../../models/auth.dart';
import '../../models/password_dto.dart';

abstract class IAuthService implements IService {
  Future<IDataResult<AuthResponse>> login(String email, String password);
  Future<void> saveUserPassword(PasswordDto passwordDto);
}
