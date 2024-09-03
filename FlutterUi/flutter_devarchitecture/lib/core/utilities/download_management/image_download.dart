import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // Web için gerekli

import 'i_download.dart';
import '/core/di/core_initializer.dart';

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

      // Platforma göre dosya kaydetme yöntemi
      if (kIsWeb) {
        // Web için dosya kaydetme
        Uint8List bytes = Uint8List.fromList(img.encodePng(image));
        saveImageWeb(bytes, 'data.png');
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Android ve iOS için dosya kaydetme
        String? outputFilePath = await _getSavePath();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(img.encodePng(image));
          _showSuccessMessage("Resim başarıyla indirildi.");
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        // macOS, Linux ve Windows için dosya kaydetme
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(img.encodePng(image));
          _showSuccessMessage("Resim başarıyla indirildi.");
        }
      }
    } catch (e) {
      // Hata mesajı
      _showErrorMessage("Resim indirilirken bir hata oluştu: $e");
    }
  }

  // Web için dosya kaydetme yöntemi
  void saveImageWeb(Uint8List bytes, String fileName) {
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
        fileName: 'data.png',
        type: FileType.custom,
        allowedExtensions: ['png'],
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
        return "$selectedDirectory/data.png";
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
