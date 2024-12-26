import 'package:flutter/material.dart';
import '../../../core/constants/temp/screen_element_constants.dart';
import '../../../core/constants/temp/sidebar_constants.dart';
import '../../../core/theme/responsive.dart';
import 'dart:async';
import 'dart:math';
import '/core/theme/extensions.dart';
import '../../../../core/di/core_initializer.dart';
import '../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../layouts/base_scaffold.dart';
import 'responsive/fake_data.dart';
import 'widgets/header_cards.dart';

part 'responsive/home_page_desktop.dart';
part 'responsive/home_page_mobile.dart';
part 'responsive/home_page_tablet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: HomePageMobile(),
        tablet: HomePageTablet(),
        desktop: HomePageDesktop());
  }
}
