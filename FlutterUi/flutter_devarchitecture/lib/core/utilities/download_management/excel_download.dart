import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

class ExcelDownload implements IExcelDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
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

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("Excel dosyası başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Excel dosyası indirilirken bir hata oluştu: $e");
    }
  }

  Future<String?> _getSavePath() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Lütfen bir çıkış dosyası seçin:',
        fileName: 'example.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      return outputFilePath;
    } catch (e) {
      // Hata mesajı (eğer dosya yolu seçimi sırasında hata olursa)
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Dosya yolu seçimi sırasında bir hata oluştu: $e");
      return null;
    }
  }
}
