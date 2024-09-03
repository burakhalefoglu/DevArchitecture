import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import "package:universal_html/html.dart" as html; // Web için gerekli

import '../../di/core_initializer.dart';
import 'i_download.dart';

class PdfDownload implements IPdfDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    try {
      final pdf = pw.Document();

      // Yazı tiplerini yükle
      final regularFontData =
          await rootBundle.load("assets/fonts/NotoSans-Regular.ttf");
      final boldFontData =
          await rootBundle.load("assets/fonts/NotoSans-Bold.ttf");

      final regularFont = pw.Font.ttf(regularFontData);
      final boldFont = pw.Font.ttf(boldFontData);

      // Sütun sayısını kontrol et
      int columnCount = data.isNotEmpty ? data.first.keys.length : 0;
      pw.PageOrientation orientation = columnCount > 5
          ? pw.PageOrientation.landscape
          : pw.PageOrientation.portrait;

      // PDF sayfasını oluştur
      pdf.addPage(
        pw.Page(
          orientation: orientation, // Sütun sayısına göre yönlendirmeyi ayarla
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Data Table",
                  style: pw.TextStyle(font: boldFont, fontSize: 24),
                ),
                pw.SizedBox(height: 20), // Boşluk

                // Excel tarzı tabloyu oluşturma
                pw.TableHelper.fromTextArray(
                  headers: data.isNotEmpty ? data.first.keys.toList() : [],
                  data: data.map((item) => item.values.toList()).toList(),
                  border: pw.TableBorder.all(width: 2),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    fontSize: 12,
                    color: PdfColors.white,
                  ),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.blue,
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 10,
                  ),
                  cellHeight: 30,
                  cellAlignments: {
                    for (int i = 0; i < data.first.keys.length; i++)
                      i: pw.Alignment.centerLeft,
                  },
                ),
              ],
            );
          },
        ),
      );

      final output = await pdf.save();

      // Platforma göre dosya kaydetme yöntemi
      if (kIsWeb) {
        // Web için dosya kaydetme
        savePdfWeb(output, 'example.pdf');
      } else if (Platform.isAndroid || Platform.isIOS) {
        // Android ve iOS için dosya kaydetme
        String? outputFilePath = await _getSavePath();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(output);
          _showSuccessMessage("PDF dosyası başarıyla indirildi.");
        }
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        // macOS, Linux ve Windows için dosya kaydetme
        String? outputFilePath = await _getSavePathForDesktop();
        if (outputFilePath != null) {
          final file = File(outputFilePath);
          await file.writeAsBytes(output);
          _showSuccessMessage("PDF dosyası başarıyla indirildi.");
        }
      }
    } catch (e) {
      // Hata mesajı
      _showErrorMessage("PDF dosyası indirilirken bir hata oluştu: $e");
    }
  }

  // Web için dosya kaydetme yöntemi
  void savePdfWeb(Uint8List bytes, String fileName) {
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
        fileName: 'example.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
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
        return "$selectedDirectory/example.pdf";
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
