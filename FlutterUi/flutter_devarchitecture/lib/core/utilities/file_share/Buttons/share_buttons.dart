import 'package:flutter/material.dart';

import '../../../constants/temp/screen_element_constants.dart';
import '../../../di/core_initializer.dart';

class ShareButtons {
  final List<Map<String, dynamic>> data;

  ShareButtons({required this.data});

  IconButton pdfButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.picture_as_pdf),
      tooltip: ScreenElementConstants.pdfShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.pdfShare.share(data);
      },
    );
  }

  IconButton excelButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.table_chart),
      tooltip: ScreenElementConstants.excelShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.excelShare.share(data);
      },
    );
  }

  IconButton txtButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.description),
      tooltip: ScreenElementConstants.txtShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.txtShare.share(data);
      },
    );
  }

  IconButton jsonButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.code),
      tooltip: ScreenElementConstants.jsonShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.jsonShare.share(data);
      },
    );
  }

  IconButton xmlButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.code),
      tooltip: ScreenElementConstants.xmlShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.xmlShare.share(data);
      },
    );
  }

  IconButton imageButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.image),
      tooltip: ScreenElementConstants.imageShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.imageShare.share(data);
      },
    );
  }

  IconButton csvButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.table_chart),
      tooltip: ScreenElementConstants.csvShareTooltip,
      onPressed: () {
        CoreInitializer().coreContainer.csvShare.share(data);
      },
    );
  }
}
