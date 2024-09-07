import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

showConfirmationDialog(BuildContext c, void Function() onPressed) {
  return showDialog(
    context: c,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          surfaceTintColor: CustomColors.white.getColor,
          backgroundColor: CustomColors.white.getColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: const Text('Emin misiniz?'),
          content: const Text('Bu işlem geri alınamaz.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              child: const Text('Evet'),
            ),
          ],
        ),
      );
    },
  );
}
