import '../../../auth/models/password_dto.dart';
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
      final usersResult =
          await BusinessInitializer().businessContainer.userService.getAll();

      if (!usersResult.isSuccess) {
        emitFailState(message: usersResult.message);
        return;
      }
      emit(BlocSuccess<List<User>>(
          usersResult.data!.map((e) => User.fromMap(e)).toList()));
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> saveUserPassword(int userId, String password) async {
    emit(BlocLoading("Kullanıcı sifresi kaydediliyor..."));
    try {
      // şifreyi güncelle
      var authService = BusinessInitializer().businessContainer.authService;
      var result = await authService
          .saveUserPassword(PasswordDto(password: password, userId: userId));
      if (!result.isSuccess) {
        emitFailState(message: result.message);
        return;
      }
      await getAllUser(); // Kullanıcıları tekrar yükleyin
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }
}
