import '/features/auth/models/password_dto.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../models/user.dart';

class UserCubit extends BaseCubit<User> {
  UserCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userService;
  }

  Future<void> getAllUser() async {
    emit(BlocLoading("Kullanıcılar getiriliyor..."));
    try {
      final users =
          await BusinessInitializer().businessContainer.userService.getAll();
      emit(BlocSuccess<List<User>>(
          users.data!.map((e) => User.fromMap(e)).toList()));
    } catch (e) {
      emit(BlocFailed("Kullanıcılar getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserPassword(int userId, String password) async {
    emit(BlocLoading("Kullanıcı sifresi kaydediliyor..."));
    try {
      // şifreyi güncelle
      var authService = BusinessInitializer().businessContainer.authService;
      await authService
          .saveUserPassword(PasswordDto(password: password, userId: userId));
      await getAllUser(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı sifresi kaydedilemedi: ${e.toString()}"));
    }
  }
}
