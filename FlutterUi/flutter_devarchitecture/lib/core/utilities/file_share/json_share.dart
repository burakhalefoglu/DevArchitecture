import 'dart:io';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'i_share.dart';

class JsonShare implements IJsonShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    final jsonString = jsonEncode(data);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/example.json');
    await file.writeAsString(jsonString);

    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Check out this JSON file!');
  }
}
