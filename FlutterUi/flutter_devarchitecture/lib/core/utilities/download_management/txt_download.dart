import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';

class TxtDownload implements ITxtDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
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
    }
  }

  Future<String?> _getSavePath() async {
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'example.txt',
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    return outputFilePath;
  }
}
