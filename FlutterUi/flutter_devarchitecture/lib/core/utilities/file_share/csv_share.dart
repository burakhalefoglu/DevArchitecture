import 'dart:io';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'i_share.dart';

class CsvShare implements ICsvShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    if (data.isEmpty) {
      print('No data to share.');
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

    // Geçici bir dosya oluşturma
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/output.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    // XFile nesnesi oluşturma
    final xFile = XFile(path);

    // Dosyayı paylaşma
    await Share.shareXFiles([xFile], text: 'Here is the CSV file.');
  }
}
