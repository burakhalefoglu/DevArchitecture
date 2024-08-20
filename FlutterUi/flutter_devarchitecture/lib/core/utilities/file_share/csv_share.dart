import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_devarchitecture/core/utilities/file_share/i_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

class CsvShare implements ICsvShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      // Veriyi CSV formatına dönüştürme
      List<List<dynamic>> rows = [];

      // Sütun başlıklarını ekleyin
      if (data.isNotEmpty) {
        List<String> headers = data.first.keys.toList();
        rows.add(headers);
      }

      // Verileri ekleyin
      for (var row in data) {
        List<dynamic> rowData = row.values.toList();
        rows.add(rowData);
      }

      // CSV verisini oluşturma
      String csvData = const ListToCsvConverter().convert(rows);

      // Geçici bir dizine kaydet
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/example.csv';
      final file = File(path);
      await file.writeAsString(csvData);

      // Paylaşma işlemini gerçekleştir
      await Share.shareXFiles(
        [XFile(path)],
        text: 'CSV dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("CSV dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("CSV dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
