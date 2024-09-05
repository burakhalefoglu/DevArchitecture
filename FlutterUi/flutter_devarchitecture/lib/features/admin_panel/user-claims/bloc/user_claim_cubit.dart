import '/features/admin_panel/user-claims/models/lookup.dart';
import '/features/admin_panel/user-claims/models/user_claim.dart';
import '../../../../core/bloc/base_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';

class UserClaimCubit extends BaseCubit<UserClaim> {
  UserClaimCubit() : super() {
    super.service = BusinessInitializer().businessContainer.userClaimService;
  }

  Future<void> getUserClaimsByUserId(int userId) async {
    emit(BlocLoading("Kullanıcılar getiriliyor..."));
    try {
      // Veritabanından kullanıcıları al
      final users = await BusinessInitializer()
          .businessContainer
          .userClaimService
          .getUserClaimsByUserId(userId);
      emit(BlocSuccess<List<LookUp>>(
        users.data!,
      ));
    } catch (e) {
      emit(BlocFailed("Kullanıcılar getirilemedi: ${e.toString()}"));
    }
  }
}
