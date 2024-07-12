import 'package:flutter/material.dart';
import '../../../core/theme/responsive.dart';
import 'responsive/admin_home_page_desktop.dart';
import 'responsive/admin_home_page_mobile.dart';
import 'responsive/admin_home_page_tablet.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: AdminHomePageMobile(),
        tablet: AdminHomePageTablet(),
        desktop: AdminHomePageDesktop());
  }
}
