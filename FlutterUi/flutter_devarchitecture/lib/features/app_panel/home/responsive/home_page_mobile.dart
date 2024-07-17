import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';
import '../../../../core/dependency_resolvers/get_it/core_initializer.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../layouts/base_scaffold.dart';
import '../../../layouts/sidebar/sidebar_constants.dart';
import '../widgets/header_cards.dart';
import 'fake_data.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final rdm = Random();
  List<Map<String, dynamic>> streamData = [];
  late Timer timer;

  @override
  void dispose() {
    streamData.clear();
    timer.cancel();
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
                            flex: 5,
                            child: buildPageTitle(
                                context, SidebarConstants.homePageTitle,
                                subDirection:
                                    SidebarConstants.appPanelPageTitle),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                              padding: context.highHorizontalPadding,
                              child: buildUsedSpaceCardWidget(context),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                                padding: context.highHorizontalPadding,
                                child: buildRevenueCardWidget(context)),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                                padding: context.highHorizontalPadding,
                                child: BuildFixedIssuesCardWidget(context)),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                                padding: context.highHorizontalPadding,
                                child: buildFollowersCardWidget(context)),
                          ),
                          const Spacer(),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .basicChart
                                  .getBarChart(
                                      context,
                                      basicData,
                                      "Kategoriler",
                                      "Satışlar",
                                      headerTitle: 'BAR CHART',
                                      CustomColors.secondary.getColor)),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .basicChart
                                  .getLineChart(
                                      context,
                                      basicData,
                                      "Kategoriler",
                                      "Satışlar",
                                      headerTitle: 'LINE CHART',
                                      CustomColors.danger.getColor)),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .basicChart
                                  .getPieChart(
                                      context,
                                      basicData,
                                      headerTitle: 'PİE CHART',
                                      "Kategoriler",
                                      "Satışlar")),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .basicChart
                                  .getStackChart(
                                    context,
                                    adjustData,
                                    headerTitle: 'STACK CHART',
                                  )),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .basicChart
                                  .getLineAreaChart(
                                      context,
                                      basicData,
                                      "Kategoriler",
                                      "Satışlar",
                                      headerTitle: 'LINE AREA CHART',
                                      CustomColors.secondary.getColor)),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .analyticsChart
                                  .getCandleStickChart(
                                    context,
                                    stockData,
                                    headerTitle: 'CANDLE STICK CHART',
                                  )),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .analyticsChart
                                  .getHeatMapChart(
                                      headerTitle: 'HEATMAP CHART',
                                      context,
                                      heatmapData,
                                      "İsim",
                                      "Gün")),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 25,
                              child: CoreInitializer()
                                  .coreContainer
                                  .analyticsChart
                                  .getScatterChart(
                                    context,
                                    scatterData,
                                    headerTitle: 'SCATTER CHART',
                                  )),
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                            flex: 25,
                            child: CoreInitializer()
                                .coreContainer
                                .eventStreamChart
                                .getEventStreamChart(
                                    context,
                                    streamData,
                                    "Kategoriler",
                                    "Satışlar",
                                    headerTitle: 'EVENT STREAM CHART',
                                    CustomColors.warning.getColor),
                          ),
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
