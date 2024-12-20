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
          surfaceTintColor: CustomColors.danger.getColor.withOpacity(0.8),
          backgroundColor: CustomColors.white.getColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: Text(
            'Emin misiniz?',
            style: TextStyle(
              color: CustomColors.danger.getColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Bu işlem geri alınamaz.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.gray.getColor,
              ),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.danger.getColor,
              ),
              child: const Text('Evet'),
            ),
          ],
        ),
      );
    },
  );
}
