import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import "package:universal_html/html.dart" as html;

import '../../constants/temp/messages.dart';
import 'i_download.dart';
import '/core/di/core_initializer.dart';

class ImageDownload implements IImageDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final int startX = 10;
      final int startY = 10;
      final int rowHeight = 30;
      final int colWidth = 250;

      final width = (colWidth * data.first.keys.length) + 200;
      final height = (rowHeight * data.length) + 200;
      final image = img.Image(width: width, height: height);
      img.fill(image, color: img.ColorRgb8(255, 255, 255));

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

      if (kIsWeb) {
        Uint8List bytes = Uint8List.fromList(img.encodePng(image));
        saveImageWeb(bytes, 'data${Random().nextInt(10000000)}.png');
      } else if (Platform.isAndroid || Platform.isIOS) {
        String? outputFilePath = await _getSavePathForMobileApps();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(img.encodePng(image));
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(img.encodePng(image));
        }
      }
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void saveImageWeb(Uint8List bytes, String fileName) {
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
        fileName: 'data${Random().nextInt(10000000)}.png',
        type: FileType.custom,
        allowedExtensions: ['png'],
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
        return "$selectedDirectory/data${Random().nextInt(10000000)}.png";
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