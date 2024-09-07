import '/features/auth/models/password_dto.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../models/user.dart';

class UserCubit extends BaseCubit<User> {
  UserCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userService;
  }

  Future<void> saveUserPassword(int userId, String password) async {
    emit(BlocLoading("Kullanıcı sifresi kaydediliyor..."));
    try {
      // şifreyi güncelle
      var authService = BusinessInitializer().businessContainer.authService;
      await authService
          .saveUserPassword(PasswordDto(password: password, userId: userId));
      await getAll(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı sifresi kaydedilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserClaims(int userId, List<int> claims) async {
    emit(BlocLoading("Kullanıcı yetkileri kaydediliyor..."));
    try {
      // yetkileri güncelle
      await BusinessInitializer()
          .businessContainer
          .userClaimService
          .update(userId, {"UserId": userId, "ClaimIds": claims});
      await getAll(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri kaydedilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserGroupPermissions(int userId, List<int> groups) async {
    emit(BlocLoading("Kullanıcı grupları kaydediliyor..."));
    try {
      // yetkileri güncelle
      await BusinessInitializer()
          .businessContainer
          .userGroupService
          .update(userId, {"UserId": userId, "GroupId": groups});
      await getAll(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri kaydedilemedi: ${e.toString()}"));
    }
  }
}
