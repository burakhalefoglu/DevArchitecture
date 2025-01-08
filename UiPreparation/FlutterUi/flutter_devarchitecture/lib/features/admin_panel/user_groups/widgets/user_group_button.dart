import 'package:flutter/material.dart';

import '../../../../core/theme/custom_colors.dart';

Widget updateUserGroupButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: Messages.groupUpdate,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.group_rounded,
            color: CustomColors.secondary.getColor,
          )),
    );
