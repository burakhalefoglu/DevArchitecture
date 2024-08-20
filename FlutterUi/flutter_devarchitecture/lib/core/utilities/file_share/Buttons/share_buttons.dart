import 'package:flutter/material.dart';

import '../../../di/core_initializer.dart';

class ShareButtons {
  final List<Map<String, dynamic>> data;

  ShareButtons({required this.data});

  IconButton pdfButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.picture_as_pdf),
      tooltip: 'Share PDF',
      onPressed: () {
        CoreInitializer().coreContainer.pdfShare.share(data);
      },
    );
  }

  IconButton excelButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.table_chart),
      tooltip: 'Share Excel',
      onPressed: () {
        CoreInitializer().coreContainer.excelShare.share(data);
      },
    );
  }

  IconButton txtButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.description),
      tooltip: 'Share TXT',
      onPressed: () {
        CoreInitializer().coreContainer.txtShare.share(data);
      },
    );
  }

  IconButton jsonButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.code),
      tooltip: 'Share JSON',
      onPressed: () {
        CoreInitializer().coreContainer.jsonShare.share(data);
      },
    );
  }

  IconButton xmlButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.code),
      tooltip: 'Share XML',
      onPressed: () {
        CoreInitializer().coreContainer.xmlShare.share(data);
      },
    );
  }

  IconButton imageButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.image),
      tooltip: 'Share Image',
      onPressed: () {
        CoreInitializer().coreContainer.imageShare.share(data);
      },
    );
  }

  IconButton csvButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.table_chart),
      tooltip: 'Share CSV',
      onPressed: () {
        CoreInitializer().coreContainer.csvShare.share(data);
      },
    );
  }
}
