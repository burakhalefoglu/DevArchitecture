import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/guard/helper.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/theme/custom_colors.dart';
import '../../core/dependency_resolvers/get_it/core_initializer.dart';
import '../../routes/routes_constants.dart';
import 'sidebar/sidebar.dart';

buildBaseScaffold(BuildContext context, Widget body, {bool isDrawer = true}) {
  return Scaffold(
    backgroundColor: CustomColors.background.getColor,
    appBar: AppBar(
      actions: [
        ModalRoute.of(context)?.settings.name == RoutesConstants.loginPage ||
                ModalRoute.of(context)?.settings.name ==
                    RoutesConstants.homePage
            ? context.emptyWidget
            : buildLogOutButton(context)
      ],
      leading: Builder(
        builder: (context) => isDrawer == false
            ? const SizedBox()
            : IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
                color: Theme.of(context).colorScheme.primary),
      ),
      backgroundColor: CustomColors.white.getColor,
      title: Text("DEVARCHITECTURE",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
              fontSize: 26)),
      centerTitle: true,
    ),
    drawer: isDrawer == true ? const NavBar() : null,
    body: body,
  );
}

Widget buildNotificationButton(BuildContext context) {
  late bool isHasNotification = true;
  return Tooltip(
    message: "Bildirimler",
    child: Stack(
      children: [
        IconButton(
            onPressed: () {
              CoreInitializer()
                  .coreContainer
                  .screenMessage
                  .getInfoMessage("Bildirimleriniz Henüz Gelmedi.");
            },
            icon: const Icon(Icons.notifications_active_outlined),
            color: Theme.of(context).colorScheme.primary),
        Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.circle,
                color: isHasNotification
                    ? CustomColors.success.getColor
                    : CustomColors.danger.getColor,
                size: 10))
      ],
    ),
  );
}

Widget buildProfileButton(BuildContext context) {
  return Tooltip(
    message: "Profil Sayfası",
    child: IconButton(
        onPressed: () {
          CoreInitializer()
              .coreContainer
              .screenMessage
              .getInfoMessage("Profil Sayfası Henüz Gelmedi.");
          // TODO: Open it when production is ready
          // Modular.to.navigate('/profile');
        },
        icon: const Icon(Icons.account_circle_outlined),
        color: Theme.of(context).colorScheme.primary),
  );
}

Widget buildLogOutButton(BuildContext context) {
  return Tooltip(
    message: "Cıkış Yap",
    child: IconButton(
        onPressed: () {
          CoreInitializer().coreContainer.storage.delete("inputPersonId");
          CoreInitializer().coreContainer.storage.delete("inputPersonName");
          CoreInitializer().coreContainer.storage.delete("token");
          Modular.to.navigate('/login');
        },
        icon: const Icon(Icons.logout),
        color: Theme.of(context).colorScheme.primary),
  );
}
