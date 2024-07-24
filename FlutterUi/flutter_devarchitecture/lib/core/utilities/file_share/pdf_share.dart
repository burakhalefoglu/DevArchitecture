import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'i_share.dart';

class PdfShare implements IPdfShare {
  @override
  Future<void> share(List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text("Pdf Share Example"),
        ),
      ),
    );

    final output = await pdf.save();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/example.pdf');
    await file.writeAsBytes(output);

    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Check out this PDF!');
  }
}
