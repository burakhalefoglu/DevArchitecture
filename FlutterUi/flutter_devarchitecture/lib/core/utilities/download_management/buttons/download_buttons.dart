import 'package:flutter/material.dart';

import '../../../di/core_initializer.dart';
import '../../../theme/custom_colors.dart';

class DownloadButtons {
  final List<Map<String, dynamic>> data;
  Color? color; // Nullable color

  DownloadButtons({
    this.color, // Color now nullable
    required this.data,
  }) {
    color ??= CustomColors.white.getColor; // Set default color if null
  }

  IconButton pdfButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.picture_as_pdf),
      tooltip: 'Download PDF',
      onPressed: () {
        CoreInitializer().coreContainer.pdfDownload.download(data);
      },
    );
  }

  IconButton excelButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.table_chart),
      tooltip: 'Download Excel',
      onPressed: () {
        CoreInitializer().coreContainer.excelDownload.download(data);
      },
    );
  }

  IconButton txtButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.description),
      tooltip: 'Download TXT',
      onPressed: () {
        CoreInitializer().coreContainer.txtDownload.download(data);
      },
    );
  }

  IconButton jsonButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.code),
      tooltip: 'Download JSON',
      onPressed: () {
        CoreInitializer().coreContainer.jsonDownload.download(data);
      },
    );
  }

  IconButton xmlButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.code),
      tooltip: 'Download XML',
      onPressed: () {
        CoreInitializer().coreContainer.xmlDownload.download(data);
      },
    );
  }

  IconButton imageButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.image),
      tooltip: 'Download Image',
      onPressed: () {
        CoreInitializer().coreContainer.imageDownload.download(data);
      },
    );
  }

  IconButton csvButton(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.table_chart),
      tooltip: 'Download CSV',
      onPressed: () {
        CoreInitializer().coreContainer.csvDownload.download(data);
      },
    );
  }
}
