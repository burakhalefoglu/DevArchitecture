import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';

class ExcelDownload implements IExcelDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Sütun başlıkları ekleyin
    if (data.isNotEmpty) {
      List<CellValue?> headerRow =
          data.first.keys.map((key) => TextCellValue(key)).toList();
      for (int i = 0; i < headerRow.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = headerRow[i];
      }
    }

    // Verileri ekleyin
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

    // Kullanıcıdan dosya indirme yolunu al
    String? outputFilePath = await _getSavePath();
    if (outputFilePath != null) {
      final file = File(outputFilePath);
      await file.writeAsBytes(excel.encode()!);
    }
  }

  Future<String?> _getSavePath() async {
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'example.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    return outputFilePath;
  }
}
