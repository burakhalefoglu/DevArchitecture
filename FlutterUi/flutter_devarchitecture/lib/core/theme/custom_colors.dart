import 'package:flutter/material.dart';
import 'theme_provider.dart';

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
}

extension SelectedColorExtension on CustomColors {
  Color get getColor {
    final isDarkMode = ThemeProvider.isDarkMode();

    switch (this) {
      case CustomColors.transparent:
        return Colors.transparent;
      case CustomColors.primary:
        return const Color.fromARGB(255, 91, 70, 249);
      case CustomColors.secondary:
        return const Color.fromARGB(255, 206, 58, 239);
      case CustomColors.success:
        return const Color.fromARGB(255, 78, 219, 146);
      case CustomColors.info:
        return const Color.fromARGB(255, 142, 151, 254);
      case CustomColors.warning:
        return const Color.fromARGB(255, 255, 174, 61);
      case CustomColors.danger:
        return const Color.fromARGB(255, 240, 80, 59);
      case CustomColors.light:
        return isDarkMode
            ? const Color.fromARGB(255, 238, 238, 238)
            : const Color.fromARGB(255, 238, 238, 238);
      case CustomColors.dark:
        return isDarkMode
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(255, 9, 9, 9);
      case CustomColors.gray:
        return isDarkMode
            ? Color.fromARGB(255, 204, 204, 204)
            : const Color.fromARGB(255, 147, 150, 157);
      case CustomColors.white:
        return isDarkMode
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color.fromARGB(255, 255, 255, 255);
      case CustomColors.baseDefault:
        return const Color.fromARGB(255, 255, 89, 34);
    }
  }
}
