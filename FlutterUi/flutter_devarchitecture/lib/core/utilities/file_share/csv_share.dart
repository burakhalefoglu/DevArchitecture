import 'dart:io';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_devarchitecture/core/constants/screen_element_constants.dart';
import 'package:flutter_devarchitecture/core/utilities/file_share/i_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';

import '../../constants/messages.dart';

class CsvShare implements ICsvShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    try {
      List<List<dynamic>> rows = [];

      if (data.isNotEmpty) {
        List<String> headers = data.first.keys.toList();
        rows.add(headers);
      }

      for (var row in data) {
        List<dynamic> rowData = row.values.toList();
        rows.add(rowData);
      }

      String csvData = const ListToCsvConverter().convert(rows);

      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/data${Random().nextInt(10000000)}.csv';
      final file = File(path);
      await file.writeAsString(csvData);

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
