import 'package:flutter/material.dart';
import '../../../core/theme/responsive.dart';
import 'responsive/home_page_desktop.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: HomePageDesktop(), //TODO: HomePageMobile()
        tablet: HomePageDesktop(), //TODO: HomePageTablet()
        desktop: HomePageDesktop());
  }
}
