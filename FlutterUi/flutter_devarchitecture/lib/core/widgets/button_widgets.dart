import 'package:flutter/material.dart';
import '../constants/messages.dart';
import '../theme/custom_colors.dart';

Widget updateGroupClaimButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: Messages.groupPermissionUpdate,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.security_rounded,
            color: CustomColors.primary.getColor,
          )),
    );

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

Widget getChangePasswordButton(BuildContext context, VoidCallback onPressed) =>
    Tooltip(
      message: Messages.passwordChange,
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

Widget getInfoHover(BuildContext context, String message, {Color? color}) =>
    Tooltip(
      message: message,
      child: Icon(
        Icons.info,
        color: color ?? CustomColors.light.getColor.withAlpha(255),
      ),
    );

Widget getEditButton(BuildContext context, VoidCallback onPressed) => Tooltip(
      message: Messages.editMessage,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            size: 24,
            Icons.edit_square,
            color: CustomColors.warning.getColor,
          )),
    );

Widget getDeleteButton(BuildContext context, VoidCallback onPressed) => Tooltip(
      message: Messages.deleteMessage,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            size: 24,
            Icons.delete_rounded,
            color: CustomColors.danger.getColor,
          )),
    );

Widget getDownloadButton(BuildContext context, VoidCallback onPressed,
        {Color? color}) =>
    Tooltip(
      message: Messages.downloadMessage,
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.download_for_offline_sharp,
            color: color ?? CustomColors.primary.getColor,
          )),
    );

Widget getAddButton(BuildContext context, VoidCallback onPressed,
        {Color? color}) =>
    Tooltip(
      message: Messages.addMessage,
      child: IconButton(
          onPressed: onPressed,
          hoverColor: CustomColors.transparent.getColor,
          icon: Icon(
            Icons.add_box_rounded,
            color: color ?? CustomColors.success.getColor,
          )),
    );

Widget getNewPageOpenButton(
        BuildContext context, final VoidCallback onPressed) =>
    Tooltip(
      message: Messages.detailedInformationMessage,
      child: IconButton(
          onPressed: onPressed,
          hoverColor: CustomColors.transparent.getColor,
          icon: Icon(
            Icons.arrow_forward,
            color: CustomColors.primary.getColor,
          )),
    );

IconButton buildScrollDirectionButton(
    bool isLeftDirection, ScrollController sc, int step, double size) {
  return IconButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        isLeftDirection == true
            ? sc.animateTo(sc.offset - (step) * 100,
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 750))
            : sc.animateTo(sc.offset + (step) * 100,
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 750));
      },
      icon: Icon(
          isLeftDirection == true
              ? Icons.chevron_left_rounded
              : Icons.chevron_right_rounded,
          color: CustomColors.primary.getColor,
          size: size));
}
