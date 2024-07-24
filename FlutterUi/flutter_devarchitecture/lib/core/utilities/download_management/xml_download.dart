import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'i_download.dart';

class XmlDownload implements IXmlDownload {
  @override
  Future<void> download(List<Map<String, dynamic>> data) async {
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

    // Kullanıcıdan dosya indirme yolunu al
    String? outputFilePath = await _getSavePath();
    if (outputFilePath != null) {
      final file = File(outputFilePath);
      await file.writeAsString(xmlString);
    }
  }

  Future<String?> _getSavePath() async {
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'example.xml',
      type: FileType.custom,
      allowedExtensions: ['xml'],
    );
    return outputFilePath;
  }
}
