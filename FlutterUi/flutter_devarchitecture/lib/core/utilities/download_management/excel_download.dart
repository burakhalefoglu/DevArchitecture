import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data'; // Uint8List için gerekli
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // Web için gerekli

import 'i_download.dart';
import '/core/di/core_initializer.dart';

class ExcelDownload implements IExcelDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
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

      // Platforma göre dosya kaydetme yöntemi
      if (kIsWeb) {
        // Web için dosya kaydetme
        Uint8List bytes = Uint8List.fromList(excel.encode()!);
        saveExcelWeb(bytes, 'example.xlsx');
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Android ve iOS için dosya kaydetme
        String? outputFilePath = await _getSavePath();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(excel.encode()!);
          _showSuccessMessage("Excel dosyası başarıyla indirildi.");
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        // macOS, Linux ve Windows için dosya kaydetme
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(excel.encode()!);
          _showSuccessMessage("Excel dosyası başarıyla indirildi.");
        }
      }
    } catch (e) {
      // Hata mesajı
      _showErrorMessage("Excel dosyası indirilirken bir hata oluştu: $e");
    }
  }

  // Web için dosya kaydetme yöntemi
  void saveExcelWeb(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  // Android ve iOS için dosya yolu seçimi
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
      _showErrorMessage("Dosya yolu seçimi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // macOS, Linux ve Windows için dosya yolu seçimi
  Future<String?> _getSavePathForDesktop() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        return "$selectedDirectory/example.xlsx";
      }
      return null;
    } catch (e) {
      _showErrorMessage("Dosya yolu seçimi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // Başarı mesajı gösterme yöntemi
  void _showSuccessMessage(String message) {
    CoreInitializer().coreContainer.screenMessage.getSuccessMessage(message);
  }

  // Hata mesajı gösterme yöntemi
  void _showErrorMessage(String message) {
    CoreInitializer().coreContainer.screenMessage.getErrorMessage(message);
  }
}
