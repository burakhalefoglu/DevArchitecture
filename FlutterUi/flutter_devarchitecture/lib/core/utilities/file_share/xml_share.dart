import 'dart:io';
import 'package:xml/xml.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cross_file/cross_file.dart';
import 'i_share.dart';

class XmlShare implements IXmlShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
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

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/example.xml');
    await file.writeAsString(xmlString);

    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Check out this XML file!');
  }
}
