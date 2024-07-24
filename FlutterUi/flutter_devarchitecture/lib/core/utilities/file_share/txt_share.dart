import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'i_share.dart';

class TxtShare implements ITxtShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/example.txt');
    final sink = file.openWrite();

    // Verileri yazdır
    for (var row in data) {
      sink.writeln(row.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(', '));
    }

    await sink.close();
    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Check out this TXT file!');
  }
}
