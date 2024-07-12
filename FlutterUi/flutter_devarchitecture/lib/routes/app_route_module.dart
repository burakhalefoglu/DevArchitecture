import 'package:flutter_devarchitecture/features/admin_panel/home/admin_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/guard/auth_guard.dart';
import '../features/app_panel/home/home_page.dart';
import '../features/auth/login_page.dart';
import '../features/not_found/not_found_page.dart';
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

    // ADMIN LAYOUT
    //*? ADMIN HOME PAGE
    r.child(RoutesConstants.adminHomePage,
        child: (context) => const AdminHomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    // APP LAYOUT
    //*? HOME PAGE
    r.child(RoutesConstants.appHomePage,
        child: (context) => const HomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    // PUBLIC LAYOUT
    //*? LOGIN PAGE
    r.child(RoutesConstants.loginPage,
        child: (context) => LoginPage(), transition: transition);

    //*? WILDCARD
    r.wildcard(
      child: (context) => const NotFoundPage(),
      transition: transition,
    );
  }
}
