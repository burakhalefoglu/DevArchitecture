import 'package:flutter/material.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../core/widgets/base_widgets.dart';
import '../../../core/widgets/tables/filter_table_widget.dart';
import '../../layouts/base_scaffold.dart';
import '../data/users.dart';

class XmlDownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final downloadButtons =
        DownloadButtons(data: users.map((e) => e.toMap()).toList());

    return buildBaseScaffold(
      context,
      Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildPageTitle(context, "XML Download Button",
                  subDirection: ""),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: users.map((e) => e.toMap()).toList(),
              headers: const [
                {"id": "id"},
                {"name": "name"},
                {"email": "email"},
                {"userType": "userType"},
              ],
              color: CustomColors.white.getColor,
              customManipulationButton: const [],
              customManipulationCallback: [],
              downloadButton: downloadButtons.xmlButton(context),
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
      isDrawer: true,
    );
  }
}
