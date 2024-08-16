import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../di/core_initializer.dart';
import 'i_share.dart';

class ExcelShare implements IExcelShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
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

      // Excel dosyasını geçici bir dizine kaydet
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/example.xlsx';
      final file = File(path);
      await file.writeAsBytes(excel.encode()!);

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: 'Excel dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("Excel dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Excel dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
