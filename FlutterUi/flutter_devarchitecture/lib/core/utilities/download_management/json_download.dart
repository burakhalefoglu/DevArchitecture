import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import "package:universal_html/html.dart" as html;

import '../../constants/messages.dart';
import 'i_download.dart';
import '/core/di/core_initializer.dart';

class JsonDownload implements IJsonDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final jsonString = jsonEncode(data);
      if (kIsWeb) {
        saveJsonWeb(jsonString, 'data${Random().nextInt(10000000)}.json');
      } else if (Platform.isAndroid || Platform.isIOS) {
        String? outputFilePath = await _getSavePathForMobileApps();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(jsonString);
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsString(jsonString);
        }
      }
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void saveJsonWeb(String jsonString, String fileName) {
    final bytes = Uint8List.fromList(utf8.encode(jsonString));
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
        fileName: 'data${Random().nextInt(10000000)}.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
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
        return "$selectedDirectory/data${Random().nextInt(10000000)}.json";
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
