import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../theme/extensions.dart';
import '../../theme/custom_colors.dart';
import '../button_widgets.dart';
import 'i_tables.dart';

class DataTables implements ITables {
  List<DataCell> _getDataCells(index, Map<String, dynamic> objList) {
    List<DataCell> dataCells = [];
    objList.forEach((_, v) => dataCells.add(DataCell(
        onTap: () {},
        Text(
            v.toString().length > 11
                ? "${v.toString().substring(0, 11)}..."
                : v.toString(),
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))));
    return dataCells;
  }

  @override
  Widget getBasicTable(BuildContext context, List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells, Color headerColor,
      {bool isBordered = false}) {
    var dataColumns = <DataColumn2>[];
    for (int i = 0; i < headers.length; i++) {
      dataColumns.add(DataColumn2(
          size: i == 0 ? ColumnSize.L : ColumnSize.S,
          label: Text(headers[i].values.first,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))));
    }

    return Padding(
      padding: context.defaultHorizontalPadding,
      child: DataTable2(
          border: isBordered
              ? TableBorder(
                  horizontalInside:
                      BorderSide(color: CustomColors.gray.getColor, width: 0.4),
                  verticalInside:
                      BorderSide(color: CustomColors.gray.getColor, width: 0.4),
                  borderRadius: BorderRadius.circular(5),
                  bottom: BorderSide(
                    color: CustomColors.gray.getColor,
                    width: 0.4,
                  ),
                  top:
                      BorderSide(color: CustomColors.gray.getColor, width: 0.4),
                  left:
                      BorderSide(color: CustomColors.gray.getColor, width: 0.4),
                  right:
                      BorderSide(color: CustomColors.gray.getColor, width: 0.4),
                )
              : null,
          showCheckboxColumn: false,
          showBottomBorder: false,
          headingRowDecoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          headingRowColor: WidgetStateProperty.all(headerColor),
          headingTextStyle: TextStyle(
            color: CustomColors.dark.getColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          dividerThickness: 0.5,
          columnSpacing: 7,
          horizontalMargin: 10,
          columns: dataColumns,
          rows: List<DataRow>.generate(cells.length, (index) {
            Map<String, dynamic> reformatedCell =
                reformatCell(headers, cells[index]);
            return DataRow(
              cells: _getDataCells(index, reformatedCell),
            );
          })),
    );
  }

  @override
  Widget getTableWithDataManipulation(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      ValueSetter<int> updateCallback,
      ValueSetter<int> deleteCallback) {
    var dataColumns = <DataColumn2>[];
    for (int i = 0; i < headers.length; i++) {
      if (i == 0) {
        dataColumns.add(
            DataColumn2(label: Text(headers[i].values.first), fixedWidth: 72));
        continue;
      }
      dataColumns.add(DataColumn2(label: Text(headers[i].values.first)));
    }
    dataColumns.add(
        const DataColumn2(label: Text(""), size: ColumnSize.S, fixedWidth: 48));
    dataColumns.add(const DataColumn2(label: Text(""), size: ColumnSize.S));

    return Padding(
      padding: context.defaultHorizontalPadding,
      child: DataTable2(
          showCheckboxColumn: false,
          showBottomBorder: false,
          headingRowDecoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          headingRowColor: WidgetStateProperty.all(headerColor),
          headingTextStyle: TextStyle(
            color: CustomColors.dark.getColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          dividerThickness: 0.5,
          columnSpacing: 5,
          horizontalMargin: 5,
          columns: dataColumns,
          rows: List<DataRow>.generate(cells.length, (index) {
            Map<String, dynamic> reformatedCell =
                reformatCell(headers, cells[index]);
            var resultCells = _getDataCells(index, reformatedCell);
            resultCells.add(DataCell(getEditButton(() {
              updateCallback(index);
            })));
            resultCells.add(DataCell(getDeleteButton(context, () {
              deleteCallback(index);
            })));

            return DataRow(cells: resultCells);
          })),
    );
  }

  Map<String, dynamic> reformatCell(
      List<Map<String, dynamic>> table, Map<String, dynamic> cell) {
    Map<String, dynamic> reformatedCell = {};
    for (int i = 0; i < table.length; i++) {
      reformatedCell[table[i].keys.first] = cell[table[i].keys.first];
    }
    return reformatedCell;
  }

  @override
  Widget getTableWithDataManipulationJustDelete(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      ValueSetter<int> deleteCallback) {
    var dataColumns = <DataColumn2>[];
    for (int i = 0; i < headers.length; i++) {
      if (i == 0) {
        dataColumns.add(
            DataColumn2(label: Text(headers[i].values.first), fixedWidth: 72));
        continue;
      }
      dataColumns.add(DataColumn2(label: Text(headers[i].values.first)));
    }
    dataColumns.add(const DataColumn2(label: Text(""), size: ColumnSize.S));

    return Padding(
      padding: context.defaultHorizontalPadding,
      child: DataTable2(
          showCheckboxColumn: false,
          showBottomBorder: false,
          headingRowDecoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          headingRowColor: WidgetStateProperty.all(headerColor),
          headingTextStyle: TextStyle(
            color: CustomColors.dark.getColor,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          dividerThickness: 0.5,
          columnSpacing: 5,
          horizontalMargin: 5,
          columns: dataColumns,
          rows: List<DataRow>.generate(cells.length, (index) {
            Map<String, dynamic> reformatedCell =
                reformatCell(headers, cells[index]);
            var resultCells = _getDataCells(index, reformatedCell);
            resultCells.add(DataCell(getDeleteButton(context, () {
              deleteCallback(index);
            })));

            return DataRow(cells: resultCells);
          })),
    );
  }
}
