import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

class TxtDownload implements ITxtDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      // Kullanıcıdan dosya indirme yolunu al
      String? outputFilePath = await _getSavePath();
      if (outputFilePath != null) {
        final file = File(outputFilePath);
        final sink = file.openWrite();

        // Verileri yazdır
        for (var row in data) {
          sink.writeln(row.entries
              .map((entry) => '${entry.key}: ${entry.value}')
              .join(', '));
        }

        await sink.close();

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("TXT dosyası başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("TXT dosyası indirilirken bir hata oluştu: $e");
    }
  }

  Future<String?> _getSavePath() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'example.txt',
        type: FileType.custom,
        allowedExtensions: ['txt'],
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
