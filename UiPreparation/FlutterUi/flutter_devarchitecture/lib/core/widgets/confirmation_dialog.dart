import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/constants/core_screen_texts.dart';
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
            CoreScreenTexts.attention,
            style: TextStyle(
              color: CustomColors.danger.getColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(CoreScreenTexts.thisActionCannotBeUndone),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.gray.getColor,
              ),
              child: Text(CoreScreenTexts.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.danger.getColor,
              ),
              child: Text(CoreScreenTexts.yes),
            ),
          ],
        ),
      );
    },
  );
}
