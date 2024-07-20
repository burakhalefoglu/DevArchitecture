import 'package:flutter/material.dart';

import '/core/theme/extensions.dart';
import '/core/widgets/tables/filter_table_widget.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/di/core_initializer.dart';
import '/core/theme/custom_colors.dart';
import '/core/widgets/button_widgets.dart';
import '/features/layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> datas = [
      {
        "docNo": "XXX-17690",
        "totalAmount": 9701.47,
        "fuelPumpName": "Merkez",
        "supplierName": "Fuel Corp",
        "unitPrice": 21.85,
        "totalPrice": 211977.12,
        "supplyDate": "2024-02-07T13:23:58.796955",
        "inputOwnerName": "Vital Trans"
      },
    ];
    return buildBaseScaffold(
      context,
      Column(
        children: [
          Expanded(
              child: Padding(
            padding: context.defaultHorizontalPadding,
            child: buildPageTitle(context, "Kullanıcı Listesi",
                subDirection: "Admin Panel"),
          )),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: const [
                {"docNo": "docNo"},
                {"totalAmount": "totalAmount"},
                {"fuelPumpName": "fuelPumpName"},
                {"supplierName": "supplierName"},
                {"unitPrice": "unitPrice"},
                {"totalPrice": "totalPrice"},
                {"supplyDate": "supplyDate"},
                {"inputOwnerName": "inputOwnerName"},
              ],
              color: CustomColors.primary.getColor,
              customManipulationButton: const [
                getChangePasswordButton,
                getChangePermissionButton,
                getChangeGroupButton,
                getEditButton,
                getDeleteButton
              ],
              customManipulationCallback: [
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
              ],
              addButton: getAddButton(
                  context,
                  () => CoreInitializer()
                      .coreContainer
                      .screenMessage
                      .getSuccessMessage("Veri Ekleme"),
                  color: CustomColors.white.getColor),
            ),
          ),
        ],
      ),
    );
  }
}
