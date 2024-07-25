import 'package:flutter/material.dart';
import '../../../routes/routes_constants.dart';
import 'helper.dart';
import 'sidebar_constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildLogoWidget(),
          buildNavElement(
            Icons.home_outlined,
            SidebarConstants.homePageTitle,
            RoutesConstants.appHomePage,
          ),
          // Admin Panel
          buildNavWithSubMenuItemElement(
              context, Icons.apps, SidebarConstants.adminPanelPageTitle, [
            {
              "name": SidebarConstants.adminPanelHomePageTitle,
              "route": RoutesConstants.adminHomePage,
              "icon": Icons.home_work_rounded
            },
            {
              "name": SidebarConstants.adminPanelPageUserTitle,
              "route": RoutesConstants.adminUserPage,
              "icon": Icons.person
            },
            {
              "name": SidebarConstants.adminPanelPageGroupTitle,
              "route": RoutesConstants.adminGroupPage,
              "icon": Icons.groups
            },
            {
              "name": SidebarConstants.adminPanelPageOperationClaimTitle,
              "route": RoutesConstants.adminOperationClaimPage,
              "icon": Icons.security
            },
            {
              "name": SidebarConstants.adminPanelPageLanguageTitle,
              "route": RoutesConstants.adminLanguagePage,
              "icon": Icons.language
            },
            {
              "name": SidebarConstants.adminPanelPageTranslateTitle,
              "route": RoutesConstants.adminTranslatePage,
              "icon": Icons.translate
            },
            {
              "name": SidebarConstants.adminPanelPageLogTitle,
              "route": RoutesConstants.adminLogPage,
              "icon": Icons.history
            },
          ]),

          // App Panel
          buildNavWithSubMenuItemElement(
              context,
              Icons.format_list_bulleted_sharp,
              SidebarConstants.appPanelPageTitle, [
            {
              "name": "Anasayfa",
              "route": RoutesConstants.appHomePage,
              "icon": Icons.home
            },
          ]),
        ],
      ),
    );
  }
}
