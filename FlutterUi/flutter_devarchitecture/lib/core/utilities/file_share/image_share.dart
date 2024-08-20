import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../di/core_initializer.dart';
import 'i_share.dart';

class ImageShare implements IImageShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      final int startX = 10; // Başlangıç x koordinatı
      final int startY = 10; // Başlangıç y koordinatı
      final int rowHeight = 30; // Satır yüksekliği
      final int colWidth = 250; // Sütun genişliği

      final width = (colWidth * data.first.keys.length) + 200; // Genişlik
      final height = (rowHeight * data.length) + 200; // Yükseklik
      final image = img.Image(width: width, height: height); // Resim boyutları
      img.fill(image, color: img.ColorRgb8(255, 255, 255)); // Beyaz arka plan

      // Sütun başlıklarını ekleyin
      if (data.isNotEmpty) {
        final headers = data.first.keys.toList();
        for (int i = 0; i < headers.length; i++) {
          img.drawString(
            image,
            headers[i],
            font: img.arial14,
            x: startX + i * colWidth,
            y: startY,
            color: img.ColorRgb8(0, 0, 0),
          );
        }
      }

      // Verileri ekleyin
      for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
        var row = data[rowIndex];
        var values = row.values.toList();
        for (int colIndex = 0; colIndex < values.length; colIndex++) {
          img.drawString(
            image,
            values[colIndex].toString(),
            font: img.arial14,
            x: startX + colIndex * colWidth,
            y: startY + (rowIndex + 1) * rowHeight,
            color: img.ColorRgb8(0, 0, 0),
          );
        }
      }

      // Geçici bir dizine kaydet
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/data.png';
      final file = File(path);
      await file.writeAsBytes(img.encodePng(image));

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: 'Resim dosyası paylaşılıyor.',
      );

      // Başarı mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getSuccessMessage("Resim dosyası başarıyla paylaşıldı.");
    } catch (e) {
      // Hata mesajı
      CoreInitializer()
          .coreContainer
          .screenMessage
          .getErrorMessage("Resim dosyası paylaşılırken bir hata oluştu: $e");
    }
  }
}
