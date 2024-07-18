import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/dependency_resolvers/get_it/core_initializer.dart';
import 'package:flutter_devarchitecture/core/theme/custom_colors.dart';
import 'package:flutter_devarchitecture/core/widgets/button_widgets.dart';
import 'package:flutter_devarchitecture/features/layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> fuelInputDtos = [
      {
        "docNo": "XXX-12345",
        "totalAmount": 10000.0,
        "fuelPumpName": "Merkez",
        "supplierName": "Vital Trans",
        "unitPrice": 22.1,
        "totalPrice": 221000.0,
        "supplyDate": DateTime.now().toIso8601String(),
        "inputOwnerName": "Vital Trans",
      }
    ];
    return buildBaseScaffold(
        context,
        Center(
            child: CoreInitializer()
                .coreContainer
                .dataTable
                .getTableWithDataCustomManipulations(
                    context,
                    [
                      {"docNo": "docNo"},
                      {"totalAmount": "totalAmount"},
                      {"fuelPumpName": "fuelPumpName"},
                      {"supplierName": "supplierName"},
                      {"unitPrice": "unitPrice"},
                      {"totalPrice": "totalPrice"},
                      {"supplyDate": "supplyDate"},
                      {"inputOwnerName": "inputOwnerName"}
                    ],
                    fuelInputDtos,
                    CustomColors.white.getColor,
                    [getDeleteButton],
                    [
                      (index) => {
                            CoreInitializer()
                                .coreContainer
                                .screenMessage
                                .getInfoMessage(index.toString())
                          }
                    ])));
  }
}
