import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'i_qr_code_scanner_service.dart';

class QRCodeScannerService implements IQRCodeScannerService {
  @override
  Future<String?> scanQrCode(GlobalKey qrKey) async {
    final completer = Completer<String?>();
    final qrView = QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        controller.scannedDataStream.first.then((barcode) {
          completer.complete(barcode.code);
          Navigator.of(qrKey.currentContext!).pop();
        });
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );

    await showDialog<void>(
      context: qrKey.currentContext!,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 300,
          height: 300,
          child: qrView,
        ),
      ),
    );

    return completer.future;
  }
}
