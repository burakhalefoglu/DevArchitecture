import 'package:flutter/material.dart';
import '../../core/theme/responsive.dart';
import 'pages/responsive/admin_home_page_desktop.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: AdminHomePageDesktop(), //TODO: AdminHomePageMobile()
        tablet: AdminHomePageDesktop(), //TODO: AdminHomePageTablet()
        desktop: AdminHomePageDesktop());
  }
}
