import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';

class JsonDownload implements IJsonDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    final jsonString = jsonEncode(data);

    // Kullanıcıdan dosya indirme yolunu al
    String? outputFilePath = await _getSavePath();
    if (outputFilePath != null) {
      final file = File(outputFilePath);
      await file.writeAsString(jsonString);
    }
  }

  Future<String?> _getSavePath() async {
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'example.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    return outputFilePath;
  }
}
