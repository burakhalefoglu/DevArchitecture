import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../di/core_initializer.dart';
import 'i_share.dart';

class JsonShare implements IJsonShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      final jsonString = jsonEncode(data);

      // JSON dosyasını geçici bir dizine kaydet
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/example.json';
      final file = File(path);
      await file.writeAsString(jsonString);

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: 'JSON dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("JSON dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("JSON dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
