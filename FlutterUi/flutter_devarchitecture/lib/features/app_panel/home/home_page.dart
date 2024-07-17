import 'package:flutter/material.dart';
import '../../../core/theme/responsive.dart';
import 'responsive/home_page_desktop.dart';
import 'responsive/home_page_mobile.dart';
import 'responsive/home_page_tablet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobile: HomePageMobile(),
        tablet: HomePageTablet(),
        desktop: HomePageDesktop());
  }
}
