import 'package:flutter/material.dart';

import '../../../../core/theme/custom_colors.dart';

Widget getChangePasswordButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: CoreMessages.passwordChange,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.password,
            color: CustomColors.primary.getColor,
          )),
    );

Widget getChangePermissionButton(
        BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: Messages.permissionChange,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.safety_check_rounded,
            color: CustomColors.secondary.getColor,
          )),
    );

Widget getChangeGroupButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
        message: Messages.groupChange,
        child: IconButton(
            hoverColor: CustomColors.transparent.getColor,
            onPressed: onPressed,
            icon: Icon(
              Icons.group,
              color: CustomColors.success.getColor,
            )));
