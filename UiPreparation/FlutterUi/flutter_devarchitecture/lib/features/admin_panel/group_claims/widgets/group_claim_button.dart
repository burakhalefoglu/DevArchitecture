import 'package:flutter/material.dart';

import '../../../../core/theme/custom_colors.dart';
import '../group_constants/group_claim_messages.dart';

Widget updateGroupClaimButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: GroupClaimMessages.groupPermissionUpdate,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.security_rounded,
            color: CustomColors.primary.getColor,
          )),
    );
