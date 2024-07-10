import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';
import 'r_u_sure.dart';

Widget getInfoHover(String message) => Tooltip(
      message: message,
      child: Icon(
        Icons.info_outline_rounded,
        color: CustomColors.gray.getColor,
      ),
    );

Widget getEditButton(VoidCallback onPressed) => Tooltip(
      message: "Veriyi Düzenle",
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
      message: "Veriyi Sil",
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: () {
            showAreYouSure(context, () {
              onPressed();
            });
          },
          icon: Icon(
            size: 24,
            Icons.delete_rounded,
            color: CustomColors.danger.getColor,
          )),
    );

Widget getDownloadButton(VoidCallback onPressed) => Tooltip(
      message: "Veriyi Excel Formatında İndir",
      child: IconButton(
          hoverColor: CustomColors.transparent.getColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.file_download_outlined,
            color: CustomColors.primary.getColor,
          )),
    );

Widget getNewRecordAddButton(final VoidCallback? onPressed) => Tooltip(
      message: "Yeni Kayıt Ekle",
      child: IconButton(
          onPressed: onPressed,
          hoverColor: CustomColors.transparent.getColor,
          icon: Icon(
            Icons.add_to_photos_outlined,
            color: CustomColors.success.getColor,
          )),
    );

Widget getNewPageOpenButton(final VoidCallback? onPressed) => Tooltip(
      message: "Ayrıntılı Bilgi...",
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
        overlayColor: MaterialStateProperty.all(Colors.transparent),
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
