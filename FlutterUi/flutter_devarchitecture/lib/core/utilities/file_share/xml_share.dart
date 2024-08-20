import 'dart:io';
import 'package:xml/xml.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../di/core_initializer.dart';
import 'i_share.dart';

class XmlShare implements IXmlShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      final builder = XmlBuilder();
      builder.processing('xml', 'version="1.0"');
      builder.element('root', nest: () {
        for (var row in data) {
          builder.element('item', nest: () {
            row.forEach((key, value) {
              builder.element(key, nest: value.toString());
            });
          });
        }
      });

      final xmlString = builder.buildDocument().toXmlString(pretty: true);

      // XML dosyasını geçici bir dizine kaydet
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/example.xml';
      final file = File(path);
      await file.writeAsString(xmlString);

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: 'XML dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("XML dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("XML dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
