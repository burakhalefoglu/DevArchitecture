import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../layouts/base_scaffold.dart';
import '../../../layouts/sidebar/sidebar_constants.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
      context,
      Padding(
        padding: context.defaultPadding,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: buildPageTitle(context, SidebarConstants.homePageTitle,
                  subDirection: SidebarConstants.appPanelPageTitle),
            ),
            Expanded(
              flex: 30,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: context.defaultPadding,
                      child: buildInfoCardWithIconAndFooter(
                          context,
                          Icons.copy,
                          color: CustomColors.warning.getColor,
                          "49/50 GB",
                          "Used Space",
                          footer: "Get More Space"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: context.defaultPadding,
                      child: buildInfoCardWithIconAndFooter(
                          context,
                          Icons.store_mall_directory,
                          color: CustomColors.success.getColor,
                          "\$34,245",
                          "Revenue",
                          footer: "Last 24 Hours"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: context.defaultPadding,
                      child: buildInfoCardWithIconAndFooter(
                          context,
                          Icons.warning_amber_rounded,
                          color: CustomColors.danger.getColor,
                          "75",
                          "FixedIssues",
                          footer: "Tracked From Github"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: context.defaultPadding,
                      child: buildInfoCardWithIconAndFooter(
                          context,
                          Icons.copy,
                          color: CustomColors.secondary.getColor,
                          "+245",
                          "Followers",
                          footer: "Just Updated"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 80, child: Text("Get Others")),
          ],
        ),
      ),
    );
  }
}
