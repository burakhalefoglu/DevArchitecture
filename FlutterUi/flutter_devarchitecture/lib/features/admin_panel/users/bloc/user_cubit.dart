import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/features/admin_panel/users/models/user.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../di/business_initializer.dart';
import '../services/i_user_service.dart';

class UserCubit extends Cubit<BaseState> {
  final IUserService userService;

  UserCubit()
      : userService = BusinessInitializer().businessContainer.userService,
        super(BlocInitial());

  Future<void> getAllUsers() async {
    emit(BlocLoading("Kullanıcılar getiriliyor..."));
    try {
      final users = await userService.getAll();
      print(users.data!);
      emit(BlocSuccess<List<User>>(
          users.data!.map((e) => User.fromMap(e)).toList()));
    } catch (e) {
      emit(BlocFailed("Kullanıcılar getirilemedi: ${e.toString()}"));
    }
  }
}
