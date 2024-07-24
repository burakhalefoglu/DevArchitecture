import 'dart:io';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'i_share.dart';

class ExcelShare implements IExcelShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Sütun başlıklarını ekleyin
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

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/example.xlsx');
    await file.writeAsBytes(excel.encode()!);

    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Check out this Excel file!');
  }
}
