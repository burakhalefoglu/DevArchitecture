import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../layouts/base_scaffold.dart';
import '../../../layouts/sidebar/sidebar_constants.dart';
import '../widgets/header_cards.dart';
import 'fake_data.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final rdm = Random();
  List<Map<String, dynamic>> streamData = [];
  late Timer timer;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    streamData.add(
      {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
    );
    streamData.add(
      {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
    );
    streamData.add(
      {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
    );

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          streamData = [
            {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
            {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
            {'x_axis': 'No.${rdm.nextInt(300)}', 'y_axis': rdm.nextInt(300)},
          ];
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: context.defaultPadding,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 10,
                            child: buildPageTitle(
                                context, SidebarConstants.homePageTitle,
                                subDirection:
                                    SidebarConstants.appPanelPageTitle),
                          ),
                          Expanded(
                            flex: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  child: buildUsedSpaceCardWidget(context),
                                ),
                                Expanded(
                                  child: buildRevenueCardWidget(context),
                                ),
                                Expanded(
                                  child: BuildFixedIssuesCardWidget(context),
                                ),
                                Expanded(
                                  child: buildFollowersCardWidget(context),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 5),
                          Expanded(
                              flex: 30,
                              child: Padding(
                                padding: context.highHorizontalPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .basicChart
                                            .getBarChart(
                                                context,
                                                basicData,
                                                "Kategoriler",
                                                "Satışlar",
                                                headerTitle: 'BAR CHART',
                                                CustomColors
                                                    .secondary.getColor)),
                                    const Spacer(),
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .basicChart
                                            .getLineChart(
                                                headerTitle: 'LINE CHART',
                                                context,
                                                basicData,
                                                "Kategoriler",
                                                "Satışlar",
                                                CustomColors.danger.getColor)),
                                    const Spacer(),
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .basicChart
                                            .getPieChart(
                                                headerTitle: 'PİE CHART',
                                                context,
                                                basicData,
                                                "Kategoriler",
                                                "Satışlar"))
                                  ],
                                ),
                              )),
                          const Spacer(flex: 5),
                          Expanded(
                              flex: 30,
                              child: Padding(
                                padding: context.highHorizontalPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .basicChart
                                            .getStackChart(
                                                headerTitle: 'STACK CHART',
                                                context,
                                                adjustData)),
                                    const Spacer(),
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .basicChart
                                            .getLineAreaChart(
                                                headerTitle: 'LINE AREA CHART',
                                                context,
                                                basicData,
                                                "Kategoriler",
                                                "Satışlar",
                                                CustomColors
                                                    .secondary.getColor)),
                                    const Spacer(),
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .analyticsChart
                                            .getCandleStickChart(
                                                headerTitle:
                                                    'CANDLE STICK CHART',
                                                context,
                                                stockData)),
                                  ],
                                ),
                              )),
                          const Spacer(flex: 5),
                          Expanded(
                              flex: 30,
                              child: Padding(
                                padding: context.highHorizontalPadding,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .analyticsChart
                                            .getHeatMapChart(
                                                context,
                                                headerTitle: 'HEATMAP CHART',
                                                heatmapData,
                                                "İsim",
                                                "Gün")),
                                    const Spacer(),
                                    Expanded(
                                        flex: 5,
                                        child: CoreInitializer()
                                            .coreContainer
                                            .analyticsChart
                                            .getScatterChart(
                                                headerTitle: 'SCATTER CHART',
                                                context,
                                                scatterData)),
                                    const Spacer(),
                                    Expanded(
                                      flex: 5,
                                      child: CoreInitializer()
                                          .coreContainer
                                          .eventStreamChart
                                          .getEventStreamChart(
                                              headerTitle: 'EVENT STREAM CHART',
                                              context,
                                              streamData,
                                              "Kategoriler",
                                              "Satışlar",
                                              CustomColors.warning.getColor),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
