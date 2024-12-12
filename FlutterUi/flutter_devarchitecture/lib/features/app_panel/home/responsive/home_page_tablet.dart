part of '../home_page.dart';

class HomePageTablet extends StatelessWidget {
  const HomePageTablet({super.key});

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
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 25,
                                  child: BuildFixedIssuesCardWidget(context),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: buildFollowersCardWidget(context),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
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
                                                context.translationProvider
                                                    .translate("Categories"),
                                                context.translationProvider
                                                    .translate("Sales"),
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
                                                context,
                                                basicData,
                                                context.translationProvider
                                                    .translate("Categories"),
                                                context.translationProvider
                                                    .translate("Sales"),
                                                headerTitle: 'LINE CHART',
                                                CustomColors.danger.getColor)),
                                  ],
                                ),
                              )),
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                              flex: 30,
                              child: Row(children: [
                                Expanded(
                                    flex: 5,
                                    child: CoreInitializer()
                                        .coreContainer
                                        .basicChart
                                        .getPieChart(
                                          context,
                                          basicData,
                                          headerTitle: 'PİE CHART',
                                          context.translationProvider
                                              .translate("Categories"),
                                          context.translationProvider
                                              .translate("Sales"),
                                        )),
                                const Spacer(),
                                Expanded(
                                    flex: 5,
                                    child: CoreInitializer()
                                        .coreContainer
                                        .basicChart
                                        .getStackChart(
                                          context,
                                          adjustData,
                                          headerTitle: 'STACK CHART',
                                        )),
                              ])),
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                              flex: 30,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: CoreInitializer()
                                          .coreContainer
                                          .basicChart
                                          .getLineAreaChart(
                                              context,
                                              basicData,
                                              context.translationProvider
                                                  .translate("Categories"),
                                              context.translationProvider
                                                  .translate("Sales"),
                                              headerTitle: 'LINE AREA CHART',
                                              CustomColors.secondary.getColor)),
                                  const Spacer(),
                                  Expanded(
                                      flex: 5,
                                      child: CoreInitializer()
                                          .coreContainer
                                          .analyticsChart
                                          .getCandleStickChart(
                                              headerTitle: 'CANDLE STICK CHART',
                                              context,
                                              stockData)),
                                ],
                              )),
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                              flex: 30,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: CoreInitializer()
                                          .coreContainer
                                          .analyticsChart
                                          .getHeatMapChart(
                                              context,
                                              heatmapData,
                                              headerTitle: 'HEATMAP CHART',
                                              context.translationProvider
                                                  .translate("Name"),
                                              context.translationProvider
                                                  .translate("Days"))),
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
                                ],
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
