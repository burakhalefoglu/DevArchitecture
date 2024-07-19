import 'package:flutter/material.dart';

import '/core/theme/extensions.dart';
import '/features/layouts/base_scaffold.dart';
import '../../../core/dependency_resolvers/get_it/core_initializer.dart';
import '../../../core/theme/custom_colors.dart';
import '../../../core/widgets/base_widgets.dart';
import '../../../core/widgets/button_widgets.dart';
import '../../../core/widgets/tables/filter_table_widget.dart';

class AdminOperationClaimPage extends StatelessWidget {
  const AdminOperationClaimPage({super.key});

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
      {
        "docNo": "XXX-50022",
        "totalAmount": 8510.78,
        "fuelPumpName": "Şube 2",
        "supplierName": "FuelMaster",
        "unitPrice": 21.06,
        "totalPrice": 179237.03,
        "supplyDate": "2024-02-13T13:23:58.796983",
        "inputOwnerName": "Fuel Corp"
      },
      {
        "docNo": "XXX-21377",
        "totalAmount": 5482.16,
        "fuelPumpName": "Şube 4",
        "supplierName": "Fuel Corp",
        "unitPrice": 23.24,
        "totalPrice": 127405.4,
        "supplyDate": "2023-10-08T13:23:58.796994",
        "inputOwnerName": "Fuel Corp"
      },
      {
        "docNo": "XXX-53434",
        "totalAmount": 5627.76,
        "fuelPumpName": "Merkez",
        "supplierName": "Vital Trans",
        "unitPrice": 24.97,
        "totalPrice": 140525.17,
        "supplyDate": "2024-03-18T13:23:58.797003",
        "inputOwnerName": "Energy Supply"
      },
      {
        "docNo": "XXX-50637",
        "totalAmount": 6648.94,
        "fuelPumpName": "Şube 1",
        "supplierName": "Energy Supply",
        "unitPrice": 23.2,
        "totalPrice": 154255.41,
        "supplyDate": "2024-06-21T13:23:58.797012",
        "inputOwnerName": "Vital Trans"
      },
      {
        "docNo": "XXX-75881",
        "totalAmount": 11086.65,
        "fuelPumpName": "Şube 1",
        "supplierName": "Energy Supply",
        "unitPrice": 23.03,
        "totalPrice": 255325.55,
        "supplyDate": "2024-04-06T13:23:58.797021",
        "inputOwnerName": "FuelMaster"
      },
      {
        "docNo": "XXX-21901",
        "totalAmount": 6072.57,
        "fuelPumpName": "Şube 3",
        "supplierName": "FuelMaster",
        "unitPrice": 24.81,
        "totalPrice": 150660.46,
        "supplyDate": "2024-03-11T13:23:58.79703",
        "inputOwnerName": "Fuel Corp"
      },
      {
        "docNo": "XXX-87766",
        "totalAmount": 13885.08,
        "fuelPumpName": "Merkez",
        "supplierName": "Vital Trans",
        "unitPrice": 21.09,
        "totalPrice": 292627.04,
        "supplyDate": "2024-05-02T13:23:58.79704",
        "inputOwnerName": "Energy Supply"
      },
      {
        "docNo": "XXX-94029",
        "totalAmount": 10841.52,
        "fuelPumpName": "Şube 3",
        "supplierName": "FuelMaster",
        "unitPrice": 23.98,
        "totalPrice": 259922.72,
        "supplyDate": "2024-01-14T13:23:58.797051",
        "inputOwnerName": "Vital Trans"
      },
      {
        "docNo": "XXX-53394",
        "totalAmount": 12292.73,
        "fuelPumpName": "Merkez",
        "supplierName": "Energy Supply",
        "unitPrice": 24.15,
        "totalPrice": 296866.34,
        "supplyDate": "2024-01-27T13:23:58.797062",
        "inputOwnerName": "FuelMaster"
      },
      {
        "docNo": "XXX-47770",
        "totalAmount": 11469.24,
        "fuelPumpName": "Merkez",
        "supplierName": "Fuel Corp",
        "unitPrice": 21.69,
        "totalPrice": 248766.84,
        "supplyDate": "2024-02-14T13:23:58.797073",
        "inputOwnerName": "Energy Supply"
      },
      {
        "docNo": "XXX-18944",
        "totalAmount": 12777.86,
        "fuelPumpName": "Şube 3",
        "supplierName": "FuelMaster",
        "unitPrice": 21.93,
        "totalPrice": 280308.69,
        "supplyDate": "2024-04-29T13:23:58.797084",
        "inputOwnerName": "Fuel Corp"
      },
      {
        "docNo": "XXX-87936",
        "totalAmount": 12888.48,
        "fuelPumpName": "Şube 3",
        "supplierName": "Fuel Corp",
        "unitPrice": 23.63,
        "totalPrice": 304570.26,
        "supplyDate": "2024-05-06T13:23:58.797095",
        "inputOwnerName": "FuelMaster"
      },
      {
        "docNo": "XXX-67622",
        "totalAmount": 13284.71,
        "fuelPumpName": "Şube 1",
        "supplierName": "Energy Supply",
        "unitPrice": 22.48,
        "totalPrice": 298515.43,
        "supplyDate": "2023-09-15T13:23:58.797106",
        "inputOwnerName": "Vital Trans"
      },
      {
        "docNo": "XXX-54297",
        "totalAmount": 6446.77,
        "fuelPumpName": "Şube 4",
        "supplierName": "FuelMaster",
        "unitPrice": 23.1,
        "totalPrice": 148722.39,
        "supplyDate": "2023-08-14T13:23:58.797117",
        "inputOwnerName": "Fuel Corp"
      },
      {
        "docNo": "XXX-85085",
        "totalAmount": 11199.88,
        "fuelPumpName": "Şube 4",
        "supplierName": "Fuel Corp",
        "unitPrice": 20.48,
        "totalPrice": 229406.14,
        "supplyDate": "2024-03-13T13:23:58.797128",
        "inputOwnerName": "Energy Supply"
      },
      {
        "docNo": "XXX-34422",
        "totalAmount": 5166.56,
        "fuelPumpName": "Şube 3",
        "supplierName": "Vital Trans",
        "unitPrice": 20.77,
        "totalPrice": 107278.9,
        "supplyDate": "2024-02-19T13:23:58.797139",
        "inputOwnerName": "Energy Supply"
      },
      {
        "docNo": "XXX-29310",
        "totalAmount": 8135.9,
        "fuelPumpName": "Şube 4",
        "supplierName": "Energy Supply",
        "unitPrice": 24.33,
        "totalPrice": 197931.65,
        "supplyDate": "2024-04-25T13:23:58.797149",
        "inputOwnerName": "FuelMaster"
      },
      {
        "docNo": "XXX-11179",
        "totalAmount": 8242.96,
        "fuelPumpName": "Merkez",
        "supplierName": "FuelMaster",
        "unitPrice": 24.55,
        "totalPrice": 202417.65,
        "supplyDate": "2023-10-25T13:23:58.797159",
        "inputOwnerName": "Vital Trans"
      },
      {
        "docNo": "XXX-88527",
        "totalAmount": 13142.84,
        "fuelPumpName": "Merkez",
        "supplierName": "Energy Supply",
        "unitPrice": 23.61,
        "totalPrice": 310210.08,
        "supplyDate": "2023-10-03T13:23:58.79717",
        "inputOwnerName": "Fuel Corp"
      },
    ];
    return buildBaseScaffold(
      context,
      Column(
        children: [
          Expanded(
              child: Padding(
            padding: context.defaultHorizontalPadding,
            child: buildPageTitle(context, "Operasyon Yetkileri Listesi",
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
              color: CustomColors.warning.getColor,
              customManipulationButton: const [
                getEditButton,
              ],
              customManipulationCallback: [
                (index) => {
                      CoreInitializer()
                          .coreContainer
                          .screenMessage
                          .getInfoMessage(index.toString())
                    },
              ],
              infoHover: getInfoHover(
                context,
                "Operasyon yetkileri burada listelenmektedir.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
