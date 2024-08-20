import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

class JsonDownload implements IJsonDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final jsonString = jsonEncode(data);

      // Kullanıcıdan dosya indirme yolunu al
      String? outputFilePath = await _getSavePath();
      if (outputFilePath != null) {
        final file = File(outputFilePath);
        await file.writeAsString(jsonString);

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("JSON dosyası başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("JSON dosyası indirilirken bir hata oluştu: $e");
    }
  }

  Future<String?> _getSavePath() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Lütfen bir çıkış dosyası seçin:',
        fileName: 'example.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
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
