import 'package:flutter_modular/flutter_modular.dart';

import '../core/guard/auth_guard.dart';
import '../features/auth/login_page.dart';
import '../features/home/pages/home_page.dart';
import 'routes_constants.dart';

class AppRouteModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthStore>(AuthStore.new);
    super.binds(i);
  }

  @override
  void routes(r) {
    var transition = TransitionType.fadeIn;
    //*? HOME PAGE
    r.child(RoutesConstants.homePage,
        child: (context) => const HomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? LOGIN PAGE
    r.child(RoutesConstants.loginPage,
        child: (context) => LoginPage(), transition: transition);

    //*? WILDCARD
    r.wildcard(
      child: (context) => const HomePage(),
      transition: transition,
    );
  }
}
