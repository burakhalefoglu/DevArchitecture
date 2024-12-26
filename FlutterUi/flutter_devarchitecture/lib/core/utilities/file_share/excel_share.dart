import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../constants/temp/messages.dart';
import '../../constants/temp/screen_element_constants.dart';
import '../../di/core_initializer.dart';
import 'i_share.dart';

class ExcelShare implements IExcelShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      if (data.isNotEmpty) {
        List<CellValue?> headerRow =
            data.first.keys.map((key) => TextCellValue(key)).toList();
        for (int i = 0; i < headerRow.length; i++) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
              .value = headerRow[i];
        }
      }
      for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
        var row = data[rowIndex];
        List<CellValue?> rowData =
            row.values.map((value) => TextCellValue(value.toString())).toList();
        for (int colIndex = 0; colIndex < rowData.length; colIndex++) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: colIndex, rowIndex: rowIndex + 1))
              .value = rowData[colIndex];
        }
      }
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/data${Random().nextInt(10000000)}.xlsx';
      final file = File(path);
      await file.writeAsBytes(excel.encode()!);

      await Share.shareXFiles(
        [XFile(path)],
        text: ScreenElementConstants.shareTitle,
      );
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _showErrorMessage(String message) {
    CoreInitializer().coreContainer.screenMessage.getErrorMessage(message);
  }
}
