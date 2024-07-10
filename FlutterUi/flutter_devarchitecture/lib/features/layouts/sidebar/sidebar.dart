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
            RoutesConstants.homePage,
          ),
          buildNavWithSubMenuItemElement(
              context, Icons.add_road_rounded, SidebarConstants.dataAddTitle, [
            // {
            //   "name": DataImportSidebarConstants.fuelInputAddTitle,
            //   "route": RoutesConstants.fuelInputAddPage,
            //   "icon": Icons.water_drop_outlined
            // },
          ]),
          // buildNavElement(
          //     Icons.local_gas_station_outlined,
          //     SidebarConstants.fuelTankProcessTitle,
          //     RoutesConstants.pumpProcessPage),
        ],
      ),
    );
  }
}
