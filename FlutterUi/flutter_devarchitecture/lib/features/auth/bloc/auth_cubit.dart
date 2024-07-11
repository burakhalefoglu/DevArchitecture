import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../core/bloc/base_cubit.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/dependency_resolvers/get_it/core_initializer.dart';
import '../../../dependency_resolver/business_initializer.dart';
import '../models/auth.dart';

class AuthCubit extends BaseCubit<AuthRequestBasic> {
  AuthCubit() : super() {
    super.service = BusinessInitializer().businessContainer.authService;
  }

  Future<void> login(AuthRequestBasic body) async {
    try {
      emit(BlocSending("Giriş Bilgileri Sistemden Sorgulanıyor!"));
      var result = await BusinessInitializer()
          .businessContainer
          .authService
          .login(body.email, body.password);
      if (!result.isSuccess) {
        emit(BlocFailed(result.message));
        return;
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(result.data!.token);
      await CoreInitializer().coreContainer.storage.save(
          "inputPersonId",
          decodedToken[
                  "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"]
              .toString());
      await CoreInitializer().coreContainer.storage.save(
          "inputPersonName",
          decodedToken[
                  "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"]
              .toString());
      await CoreInitializer()
          .coreContainer
          .storage
          .save("token", result.data!.token.toString());
      await CoreInitializer()
          .coreContainer
          .storage
          .save("refreshToken", result.data!.refreshToken.toString());
      await CoreInitializer()
          .coreContainer
          .storage
          .save("token_expiration", result.data!.expiration.toString());
      await CoreInitializer()
          .coreContainer
          .storage
          .save("claims", result.data!.claims.toString());

      emit(BlocSuccess(
          'Hoşgeldiniz. ${decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"].toString()}'));
    } catch (e) {
      emit(BlocFailed(e.toString()));
    }
  }
}
