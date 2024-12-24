import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/temp/messages.dart';
import '../../constants/screen_element_constants.dart';
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

      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/data${Random().nextInt(100000)}.xml';
      final file = File(path);
      await file.writeAsString(xmlString);

      // Dosyayı paylaş
      await Share.shareXFiles(
        [XFile(path)],
        text: ScreenElementConstants.shareTitle,
      );
    } catch (e) {
      _showErrorMessage(Messages.customerDefaultErrorMessage);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _showErrorMessage(String message) {
    CoreInitializer().coreContainer.screenMessage.getErrorMessage(message);
  }
}
