import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_devarchitecture/core/constants/screen_element_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/messages.dart';
import '../../di/core_initializer.dart';
import 'i_share.dart';

class TxtShare implements ITxtShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/data${Random().nextInt(10000000)}".txt';
      final file = File(path);
      final sink = file.openWrite();

      for (var row in data) {
        sink.writeln(row.entries
            .map((entry) => '${entry.key}: ${entry.value}')
            .join(', '));
      }

      await sink.close();
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
