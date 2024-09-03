import 'dart:io';
import 'dart:typed_data';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import "package:universal_html/html.dart" as html; // Web için gerekli

import 'i_download.dart';
import '/core/di/core_initializer.dart';

class XmlDownload implements IXmlDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      // XML verisini oluşturma
      final builder = XmlBuilder();
      builder.processing('xml', 'version="1.0"');
      builder.element('root', nest: () {
        for (var row in data) {
          builder.element('item', nest: () {
            row.forEach((key, value) {
              builder.element(key, nest: value.toString());
            });
          });
        }
      });

      final xmlString = builder.buildDocument().toXmlString(pretty: true);

      // Platforma göre dosya kaydetme yöntemi
      if (kIsWeb) {
        // Web için dosya kaydetme
        saveXmlWeb(xmlString, 'example.xml');
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Android ve iOS için dosya kaydetme
        String? outputFilePath = await _getSavePath();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(xmlString);
          _showSuccessMessage("XML dosyası başarıyla indirildi.");
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        // macOS, Linux ve Windows için dosya kaydetme
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(xmlString);
          _showSuccessMessage("XML dosyası başarıyla indirildi.");
        }
      }
    } catch (e) {
      // Hata mesajı
      _showErrorMessage("XML dosyası indirilirken bir hata oluştu: $e");
    }
  }

  // Web için dosya kaydetme yöntemi
  void saveXmlWeb(String xmlString, String fileName) {
    final bytes = Uint8List.fromList(xmlString.codeUnits);
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
        dialogTitle: 'Please select an output file:',
        fileName: 'example.xml',
        type: FileType.custom,
        allowedExtensions: ['xml'],
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
        return "$selectedDirectory/example.xml";
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
