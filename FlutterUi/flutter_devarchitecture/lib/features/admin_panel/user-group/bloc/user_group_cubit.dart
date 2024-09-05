import '../../user-claims/models/lookup.dart';
import '../models/user_group.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class UserGroupCubit extends BaseCubit<UserGroup> {
  UserGroupCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userGroupService;
  }

  Future<void> getUserGroupsByUserId(int userId) async {
    emit(BlocLoading("Kullanıcı grupları getiriliyor..."));
    try {
      // Veritabanından kullanıcı gruplarını al
      final groups = await BusinessInitializer()
          .businessContainer
          .userGroupService
          .getUserGroupsByUserId(userId);
      emit(BlocSuccess<List<LookUp>>(
        groups.data!,
      ));
    } catch (e) {
      emit(BlocFailed("Kullanıcı grupları getirilemedi: ${e.toString()}"));
    }
  }
}
