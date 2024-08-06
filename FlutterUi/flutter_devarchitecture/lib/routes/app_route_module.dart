import 'package:flutter_devarchitecture/features/admin_panel/languages/admin_language_page.dart';
import 'package:flutter_devarchitecture/features/admin_panel/users/pages/admin_user_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/guard/auth_guard.dart';
import '../features/admin_panel/groups/admin_group_page.dart';
import '../features/admin_panel/logs/logs.dart';
import '../features/admin_panel/operation_claims/admin_operation_claim_page.dart';
import '../features/admin_panel/translates/admin_translate_page.dart';
import '../features/app_panel/home/home_page.dart';
import '../features/public/auth/login_page.dart';
import '../features/public/not_found/not_found_page.dart';
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
        child: (context) => const HomePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN USER PAGE
    r.child(RoutesConstants.adminUserPage,
        child: (context) => const AdminUserPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN GROUP PAGE
    r.child(RoutesConstants.adminGroupPage,
        child: (context) => const AdminGroupPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN OPERATION CLAIM PAGE
    r.child(RoutesConstants.adminOperationClaimPage,
        child: (context) => const AdminOperationClaimPage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN LANGUAGE PAGE
    r.child(RoutesConstants.adminLanguagePage,
        child: (context) => const AdminLanguagePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN TRANSLATE PAGE
    r.child(RoutesConstants.adminTranslatePage,
        child: (context) => const AdminTranslatePage(),
        transition: transition,
        guards: [AuthGuard()]);

    //*? ADMIN LOG PAGE
    r.child(RoutesConstants.adminLogPage,
        child: (context) => const AdminLogPage(),
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
