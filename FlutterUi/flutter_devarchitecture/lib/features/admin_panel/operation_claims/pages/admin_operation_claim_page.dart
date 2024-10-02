import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/button_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';
import '../../../layouts/base_scaffold.dart';
import '../bloc/operation_claim_cubit.dart';
import '../models/operation_claim.dart';
import '../widgets/update_operation_claim_dialog.dart';

class AdminOperationClaimPage extends StatelessWidget {
  const AdminOperationClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OperationClaimCubit(),
      child: BlocConsumer<OperationClaimCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          if (state is BlocInitial || state is BlocLoading) {
            BlocProvider.of<OperationClaimCubit>(context).getAll();
            return const Center(child: CircularProgressIndicator());
          }
          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            tableData = state.result!.isNotEmpty ? state.result! : [];
          }

          return buildBaseScaffold(
            context,
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: context.defaultHorizontalPadding,
                    child: buildPageTitle(
                      context,
                      "Operasyon Yetkileri Listesi",
                      subDirection: "Admin Panel",
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: FilterTableWidget(
                    datas: tableData,
                    headers: const [
                      {"id": "ID"},
                      {"name": "Yetki Adı"},
                      {"alias": "Takma Ad"},
                      {"description": "Açıklama"},
                    ],
                    color: CustomColors.warning.getColor,
                    customManipulationButton: const [
                      getEditButton,
                    ],
                    customManipulationCallback: [
                      (index) => _editOperationClaim(
                          context,
                          tableData
                              .firstWhere((element) => element['id'] == index)),
                    ],
                    infoHover: getInfoHover(
                      color: CustomColors.dark.getColor,
                      context,
                      "Operasyon yetkileri burada listelenmektedir.",
                    ),
                    utilityButton: DownloadButtons(
                            color: CustomColors.dark.getColor,
                            data:
                                state is BlocSuccess<List<Map<String, dynamic>>>
                                    ? state.result!
                                    : [])
                        .excelButton(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _editOperationClaim(
      BuildContext context, Map<String, dynamic> operationClaimData) async {
    final updatedOperationClaim = await showDialog(
      context: context,
      builder: (c) => UpdateOperationClaimDialog(
        operationClaim: OperationClaim.fromMap(operationClaimData),
      ),
    );
    if (updatedOperationClaim != null) {
      BlocProvider.of<OperationClaimCubit>(context)
          .updateOperationClaim(updatedOperationClaim);
    }
  }
}
