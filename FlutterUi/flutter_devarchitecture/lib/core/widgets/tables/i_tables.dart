import 'package:flutter/material.dart';

abstract class ITables {
  Widget getBasicTable(BuildContext context, List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells, Color headerColor,
      {bool isBordered = false});

  Widget getTableWithDataManipulation(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      ValueSetter<int> updateCallback,
      ValueSetter<int> deleteCallback);

  Widget getTableWithDataManipulationJustDelete(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      ValueSetter<int> deleteCallback);

  Widget getTableWithDataCustomManipulations(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      List<Widget Function(BuildContext context, void Function())>
          customManipulationButton,
      List<ValueSetter<int>> customManipulationCallback);
}
