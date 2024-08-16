import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

import 'i_download.dart';

class ImageDownload implements IImageDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final int startX = 10; // Başlangıç x koordinatı
      final int startY = 10; // Başlangıç y koordinatı
      final int rowHeight = 30; // Satır yüksekliği
      final int colWidth = 250; // Sütun genişliği

      final width = (colWidth * data.first.keys.length) + 200; // Genişlik
      final height = (rowHeight * data.length) + 200; // Yükseklik
      final image = img.Image(width: width, height: height); // Resim boyutları
      img.fill(image, color: img.ColorRgb8(255, 255, 255)); // Beyaz arka plan

      // Sütun başlıklarını ekleyin
      if (data.isNotEmpty) {
        final headers = data.first.keys.toList();
        for (int i = 0; i < headers.length; i++) {
          img.drawString(
            image,
            headers[i],
            font: img.arial14,
            x: startX + i * colWidth,
            y: startY,
            color: img.ColorRgb8(0, 0, 0),
          );
        }
      }

      // Verileri ekleyin
      for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
        var row = data[rowIndex];
        var values = row.values.toList();
        for (int colIndex = 0; colIndex < values.length; colIndex++) {
          img.drawString(
            image,
            values[colIndex].toString(),
            font: img.arial14,
            x: startX + colIndex * colWidth,
            y: startY + (rowIndex + 1) * rowHeight,
            color: img.ColorRgb8(0, 0, 0),
          );
        }
      }

      // Kullanıcıdan dosya indirme yolunu al
      String? outputFilePath = await _getSavePath();
      if (outputFilePath != null) {
        final file = File(outputFilePath);
        await file.writeAsBytes(img.encodePng(image));

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("Resim başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Resim indirilirken bir hata oluştu: $e");
    }
  }

  Future<String?> _getSavePath() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Lütfen bir çıkış dosyası seçin:',
        fileName: 'data.png',
        type: FileType.custom,
        allowedExtensions: ['png'],
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
