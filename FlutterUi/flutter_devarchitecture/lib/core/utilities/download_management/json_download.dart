import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // Web için gerekli

import 'i_download.dart';
import '/core/di/core_initializer.dart';

class JsonDownload implements IJsonDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final jsonString = jsonEncode(data);

      // Platforma göre dosya kaydetme yöntemi
      if (kIsWeb) {
        // Web için dosya kaydetme
        saveJsonWeb(jsonString, 'example.json');
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Android ve iOS için dosya kaydetme
        String? outputFilePath = await _getSavePath();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(jsonString);
          _showSuccessMessage("JSON dosyası başarıyla indirildi.");
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        // macOS, Linux ve Windows için dosya kaydetme
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(jsonString);
          _showSuccessMessage("JSON dosyası başarıyla indirildi.");
        }
      }
    } catch (e) {
      // Hata mesajı
      _showErrorMessage("JSON dosyası indirilirken bir hata oluştu: $e");
    }
  }

  // Web için dosya kaydetme yöntemi
  void saveJsonWeb(String jsonString, String fileName) {
    final bytes = Uint8List.fromList(utf8.encode(jsonString));
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
        fileName: 'example.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
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
        return "$selectedDirectory/example.json";
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
