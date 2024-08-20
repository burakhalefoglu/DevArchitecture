import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

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

      // Kullanıcıdan dosya indirme yolunu al
      String? outputFilePath = await _getSavePath();
      if (outputFilePath != null) {
        final file = File(outputFilePath);
        await file.writeAsBytes(output);

        // Başarı mesajı
        CoreInitializer()
            .coreContainer
            .screenMessage
            .getSuccessMessage("PDF dosyası başarıyla indirildi.");
      }
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("PDF dosyası indirilirken bir hata oluştu: $e");
    }
  }

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
      // Hata mesajı (eğer dosya yolu seçimi sırasında hata olursa)
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Dosya yolu seçimi sırasında bir hata oluştu: $e");
      return null;
    }
  }
}
