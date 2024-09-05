import '/features/auth/models/password_dto.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../models/user.dart';

class UserCubit extends BaseCubit<User> {
  UserCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userService;
  }

  Future<void> getAllUsers() async {
    emit(BlocLoading("Kullanıcılar getiriliyor..."));
    try {
      // Veritabanından kullanıcıları al
      final users = await service.getAll();
      emit(BlocSuccess<List<User>>(
        users.data!.map((e) => User.fromMap(e)).toList(),
      ));
    } catch (e) {
      emit(BlocFailed("Kullanıcılar getirilemedi: ${e.toString()}"));
    }
  }

  Future<void> addUser(User user) async {
    emit(BlocLoading("Kullanıcı ekleniyor..."));
    try {
      // Kullanıcıyı veritabanına ekle
      await service.create(user.toMap());
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı eklenemedi: ${e.toString()}"));
    }
  }

  Future<void> updateUser(User updatedUser) async {
    emit(BlocLoading("Kullanıcı güncelleniyor..."));
    try {
      // Kullanıcıyı veritabanında güncelle
      await service.update(updatedUser.id, updatedUser.toMap());
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı güncellenemedi: ${e.toString()}"));
    }
  }

  Future<void> deleteUser(int userId) async {
    emit(BlocLoading("Kullanıcı siliniyor..."));
    try {
      // Kullanıcıyı veritabanından sil
      await service.delete(userId);
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı silinemedi: ${e.toString()}"));
    }
  }

  Future<void> saveUserPassword(int userId, String password) async {
    emit(BlocLoading("Kullanıcı sifresi kaydediliyor..."));
    try {
      // şifreyi güncelle
      var authService = BusinessInitializer().businessContainer.authService;
      await authService
          .saveUserPassword(PasswordDto(password: password, userId: userId));
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
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
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
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
      await getAllUsers(); // Kullanıcıları tekrar yükleyin
    } catch (e) {
      emit(BlocFailed("Kullanıcı yetkileri kaydedilemedi: ${e.toString()}"));
    }
  }
}
