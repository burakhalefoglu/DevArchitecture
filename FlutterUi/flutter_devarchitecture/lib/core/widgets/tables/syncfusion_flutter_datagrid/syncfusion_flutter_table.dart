import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../i_tables.dart';

class SyncfusionDataTable implements ITables {
  @override
  Widget getBasicTable(BuildContext context, List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells, Color headerColor,
      {bool isBordered = false}) {
    final dataSource = _buildDataGridSource(context, headers, cells);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfDataGrid(
        source: dataSource,
        columns: headers
            .map((header) => GridColumn(
                  columnName: header.keys.first,
                  label: Container(
                    color: headerColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      header.values.first,
                      style: TextStyle(
                        color: headerColor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
            .toList(),
        gridLinesVisibility: isBordered
            ? GridLinesVisibility.horizontal
            : GridLinesVisibility.none,
        headerGridLinesVisibility: isBordered
            ? GridLinesVisibility.horizontal
            : GridLinesVisibility.none,
        columnWidthMode: ColumnWidthMode.fill,
      ),
    );
  }

  @override
  Widget getTableWithCustomManipulationButtons(
      BuildContext context,
      List<Map<String, dynamic>> headers,
      List<Map<String, dynamic>> cells,
      Color headerColor,
      List<Widget Function(BuildContext context, void Function())>
          customManipulationButton,
      List<ValueSetter<int>> customManipulationCallback,
      {bool isBordered = false,
      Widget? infoHover,
      Widget? addButton,
      Widget? utilityButton}) {
    final dataSource = _buildDataGridSource(context, headers, cells,
        customButtons: customManipulationButton,
        callbacks: customManipulationCallback);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfDataGrid(
        source: dataSource,
        columns: [
          ...headers
              .map((header) => GridColumn(
                    columnName: header.keys.first,
                    label: Container(
                      color: headerColor,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        header.values.first,
                        style: TextStyle(
                          color: headerColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          if (infoHover != null)
            GridColumn(
                columnName: 'Info',
                label: Container(
                  alignment: Alignment.center,
                  child: infoHover,
                )),
          if (addButton != null)
            GridColumn(
                columnName: 'Add',
                label: Container(
                  alignment: Alignment.center,
                  child: addButton,
                )),
          if (utilityButton != null)
            GridColumn(
                columnName: 'Utility',
                label: Container(
                  alignment: Alignment.center,
                  child: utilityButton,
                )),
        ],
        gridLinesVisibility: isBordered
            ? GridLinesVisibility.horizontal
            : GridLinesVisibility.none,
        headerGridLinesVisibility: isBordered
            ? GridLinesVisibility.horizontal
            : GridLinesVisibility.none,
        columnWidthMode: ColumnWidthMode.fill,
      ),
    );
  }

  _CustomDataGridSource _buildDataGridSource(
    BuildContext context,
    List<Map<String, dynamic>> headers,
    List<Map<String, dynamic>> cells, {
    List<Widget Function(BuildContext context, void Function())>? customButtons,
    List<ValueSetter<int>>? callbacks,
  }) {
    return _CustomDataGridSource(
        context, headers, cells, customButtons, callbacks);
  }
}

class _CustomDataGridSource extends DataGridSource {
  final BuildContext context; // BuildContext eklendi
  final List<Map<String, dynamic>> headers;
  final List<Map<String, dynamic>> cells;
  final List<Widget Function(BuildContext context, void Function())>?
      customButtons;
  final List<ValueSetter<int>>? callbacks;

  _CustomDataGridSource(this.context, this.headers, this.cells,
      this.customButtons, this.callbacks);

  @override
  List<DataGridRow> get rows => cells.map((cell) {
        final List<DataGridCell> gridCells = headers.map((header) {
          final key = header.keys.first;
          return DataGridCell(
              columnName: key, value: cell[key]?.toString() ?? '');
        }).toList();

        if (customButtons != null) {
          for (int i = 0; i < customButtons!.length; i++) {
            gridCells.add(DataGridCell(
                columnName: 'Action_$i',
                value: customButtons![i](
                    context, () => callbacks?[i](cell["id"] ?? 0))));
          }
        }

        return DataGridRow(cells: gridCells);
      }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((cell) {
      if (cell.value is Widget) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: cell.value,
        );
      }
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          cell.value.toString(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      );
    }).toList());
  }
}
