import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../di/core_initializer.dart';
import 'i_share.dart';

class TxtShare implements ITxtShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      // Geçici bir dizine kaydetmek için dosya yolu oluştur
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/example.txt';
      final file = File(path);
      final sink = file.openWrite();

      // Verileri yazdır
      for (var row in data) {
        sink.writeln(row.entries
            .map((entry) => '${entry.key}: ${entry.value}')
            .join(', '));
      }

      await sink.close();

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: 'TXT dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("TXT dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("TXT dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
