import 'package:flutter_devarchitecture/features/admin_panel/admin_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/guard/auth_guard.dart';
import '../features/auth/login_page.dart';
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
    r.child(RoutesConstants.adminHomePage,
        child: (context) => const AdminHomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? HOME PAGE
    r.child(RoutesConstants.homePage,
        child: (context) => LoginPage(), transition: transition);

    //*? LOGIN PAGE
    r.child(RoutesConstants.loginPage,
        child: (context) => LoginPage(), transition: transition);

    //*? WILDCARD
    r.wildcard(
      child: (context) => LoginPage(),
      transition: transition,
    );
  }
}
