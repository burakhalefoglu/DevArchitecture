import 'package:flutter/material.dart';

import '../../../theme/custom_colors.dart';
import '../../../utilities/download_management/buttons/download_buttons.dart';
import '../../../widgets/base_widgets.dart';
import '../../../widgets/tables/filter_table_widget.dart';
import '../../../../layouts/base_scaffold.dart';
import '../data/users.dart';

class CsvDownloadPage extends StatelessWidget {
  CsvDownloadPage({super.key});
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
              child: buildPageTitle(context, "Csv Download Button",
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
              utilityButton: downloadButtons.csvButton(context),
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
