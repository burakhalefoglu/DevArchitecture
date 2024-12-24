import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import '/core/constants/messages.dart';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import "package:universal_html/html.dart" as html;

import 'i_download.dart';
import '/core/di/core_initializer.dart';

class XmlDownload implements IXmlDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
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

      if (kIsWeb) {
        saveXmlWeb(xmlString, 'data${Random().nextInt(10000000)}.xml');
        String? outputFilePath = await _getSavePathForMobileApps();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(xmlString);
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(xmlString);
        }
      }
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void saveXmlWeb(String xmlString, String fileName) {
    final bytes = Uint8List.fromList(xmlString.codeUnits);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  Future<String?> _getSavePathForMobileApps() async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: Messages.selectOutputFileMessage,
        fileName: 'data${Random().nextInt(10000000)}.xml',
        type: FileType.custom,
        allowedExtensions: ['xml'],
      );
      return outputFilePath;
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<String?> _getSavePathForDesktop() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        return "$selectedDirectory/data${Random().nextInt(10000000)}.xml";
      }
      return null;
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void _showErrorMessage(String message) {
    CoreInitializer().coreContainer.screenMessage.getErrorMessage(message);
  }
}
