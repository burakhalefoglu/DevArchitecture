import 'package:flutter/material.dart';
import '/core/theme/extensions.dart';

import 'custom_colors.dart';

ThemeData buildTheme(BuildContext context) {
  return ThemeData(
    menuTheme: MenuBarThemeData(
        style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(CustomColors.white.getColor),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: context.lowBorderRadius,
        )),
        backgroundColor: WidgetStateProperty.all(
            CustomColors.buttonBackgroundPrimary.getColor),
        foregroundColor: WidgetStateProperty.all(CustomColors.white.getColor),
      ),
    ),
    fontFamily: context.fontFamily,
    textTheme:
        Theme.of(context).textTheme.apply(fontFamily: context.fontFamily),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: WidgetStateProperty.all(CustomColors.primary.getColor)),
    ),
    iconTheme: IconThemeData(size: 26, color: CustomColors.primary.getColor),
    listTileTheme: ListTileThemeData(
      leadingAndTrailingTextStyle: TextStyle(
        color: CustomColors.dark.getColor,
        fontWeight: FontWeight.w800,
        fontSize: 15,
        fontFamily: context.fontFamily,
      ),
      titleTextStyle: TextStyle(
        color: CustomColors.primary.getColor,
        fontWeight: FontWeight.w800,
        fontFamily: context.fontFamily,
        fontSize: 18,
      ),
      iconColor: CustomColors.primary.getColor,
      selectedColor: CustomColors.white.getColor,
    ),
    colorScheme: ColorScheme.fromSeed(
        background: CustomColors.white.getColor,
        seedColor: CustomColors.primary.getColor,
        primary: CustomColors.primary.getColor),
    useMaterial3: true,
  );
}
