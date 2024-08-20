import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

import 'i_download.dart';

class CsvDownload implements ICsvDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      // Veriyi CSV formatına dönüştürme
      List<List<dynamic>> rows = [];

      // Sütun başlıklarını ekleyin
      if (data.isNotEmpty) {
        List<String> headers = data.first.keys.toList();
        rows.add(headers);
      }

      // Verileri ekleyin
      for (var row in data) {
        List<dynamic> rowData = row.values.toList();
        rows.add(rowData);
      }

      // CSV verisini oluşturma
      String csvData = const ListToCsvConverter().convert(rows);

      // Kullanıcıdan dosya indirme yolunu al
      String? outputFilePath = await _getSavePath();
      if (outputFilePath != null) {
        final file = File(outputFilePath);
        await file.writeAsString(csvData);

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("CSV dosyası başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("CSV dosyası indirilirken bir hata oluştu: $e");
    }
  }

  Future<String?> _getSavePath() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Lütfen bir çıkış dosyası seçin:',
        fileName: 'example.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
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
