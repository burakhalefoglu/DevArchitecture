import 'package:flutter_devarchitecture/extensions/claim_provider_extentions.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes_constants.dart';

class ModularClaimGuard extends RouteGuard {
  String claim;
  ModularClaimGuard({required this.claim})
      : super(redirectTo: RoutesConstants.appHomePage);

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return ClaimStore(claim: claim).isClaim;
  }
}

class ClaimStore {
  String claim;
  ClaimStore({required this.claim});

  Future<bool> get isClaim async {
    final context = Modular.routerDelegate.navigatorKey.currentContext;

    if (context == null) {
      return false;
    }
    return await context.claimProvider.hasClaim(context, claim);
  }
}
