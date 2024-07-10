import 'package:flutter/material.dart';

abstract class IChart {}

abstract class IGaugesChart implements IChart {
  Widget getCircleGaugeChart(
      double start, double end, double valid, Color color, Color pointerColor);

  Widget getVerticalGaugeChart(
      double start, double end, double valid, Color color, Color pointerColor);
}

abstract class IAnalyticsChart implements IChart {}

abstract class ILoaderChart implements IChart {
  Widget getLoaderChart(
      BuildContext context, double start, double end, double valid);
}
