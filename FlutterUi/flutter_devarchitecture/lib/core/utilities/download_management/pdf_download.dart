import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';

class PdfDownload implements IPdfDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text("Pdf Download Example"),
        ),
      ),
    );

    final output = await pdf.save();

    // Kullanıcıdan dosya indirme yolunu al
    String? outputFilePath = await _getSavePath();
    if (outputFilePath != null) {
      final file = File(outputFilePath);
      await file.writeAsBytes(output);
    }
  }

  Future<String?> _getSavePath() async {
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'example.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return outputFilePath;
  }
}
