import 'dart:io';
import 'package:csv/csv.dart';

import 'i_download.dart';

class CsvDownload implements ICsvDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
    if (data.isEmpty) {
      print('No data to download.');
      return;
    }

    // Başlık satırını oluşturma
    List<String> headers = data.first.keys.toList();

    // Veri satırlarını oluşturma
    List<List<dynamic>> rows = [];
    rows.add(headers);
    for (var row in data) {
      rows.add(headers.map((header) => row[header]).toList());
    }

    // CSV verisini oluşturma
    String csvData = const ListToCsvConverter().convert(rows);

    // CSV dosyasını kaydetme
    final file = File("output.csv");
    await file.writeAsString(csvData);

    print('CSV file downloaded successfully.');
  }
}
