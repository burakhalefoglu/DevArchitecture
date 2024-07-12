import 'package:flutter/material.dart';
import '../../../routes/routes_constants.dart';
import 'helper.dart';
import 'sidebar_constants.dart';
import '../../../../core/theme/custom_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: CustomColors.white.getColor,
      backgroundColor: CustomColors.white.getColor,
      child: ListView(
        children: [
          buildLogoWidget(),
          buildNavElement(
            Icons.home_outlined,
            SidebarConstants.homePageTitle,
            RoutesConstants.appHomePage,
          ),
          buildNavWithSubMenuItemElement(
              context, Icons.apps, SidebarConstants.adminPanelPageTitle, [
            {
              "name": "Anasayfa",
              "route": RoutesConstants.adminHomePage,
              "icon": Icons.home_work_rounded
            },
          ]),
          buildNavWithSubMenuItemElement(
              context,
              Icons.format_list_bulleted_sharp,
              SidebarConstants.appPanelPageTitle, [
            {
              "name": "Anasayfa",
              "route": RoutesConstants.appHomePage,
              "icon": Icons.home_work_rounded
            },
          ]),
        ],
      ),
    );
  }
}
