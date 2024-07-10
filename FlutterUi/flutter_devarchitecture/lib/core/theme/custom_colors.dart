import 'package:flutter/material.dart';

enum CustomColors {
  baseDefault,
  transparent,
  primary,
  secondary,
  success,
  info,
  warning,
  danger,
  light,
  gray,
  dark,
  white,
  background,
  buttonBackgroundPrimary,
  buttonBackgroundSecondary
}

extension SelectedColorExtension on CustomColors {
  Color get getColor {
    switch (this) {
      case CustomColors.transparent:
        return Colors.transparent;
      case CustomColors.buttonBackgroundPrimary:
        return const Color.fromARGB(255, 91, 70, 249);
      case CustomColors.buttonBackgroundSecondary:
        return const Color.fromARGB(255, 217, 76, 249);
      case CustomColors.primary:
        return const Color.fromARGB(255, 91, 70, 249);
      case CustomColors.secondary:
        return const Color.fromARGB(255, 230, 116, 255);
      case CustomColors.success:
        return const Color.fromARGB(255, 115, 198, 155);
      case CustomColors.info:
        return const Color.fromARGB(255, 142, 151, 254);
      case CustomColors.warning:
        return const Color.fromARGB(255, 254, 200, 125);
      case CustomColors.danger:
        return const Color.fromARGB(255, 246, 122, 106);
      case CustomColors.light:
        return const Color.fromARGB(255, 238, 238, 238);
      case CustomColors.dark:
        return const Color.fromARGB(255, 58, 58, 84);
      case CustomColors.gray:
        return const Color.fromARGB(255, 147, 150, 157);
      case CustomColors.white:
        return const Color.fromARGB(255, 255, 255, 255);
      case CustomColors.background:
        return const Color.fromARGB(255, 255, 255, 255);
      case CustomColors.baseDefault:
        return const Color.fromARGB(255, 255, 89, 34);
    }
  }
}
