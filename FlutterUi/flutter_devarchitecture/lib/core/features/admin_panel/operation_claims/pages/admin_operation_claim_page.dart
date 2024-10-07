import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';

import '../../../../bloc/base_state.dart';
import '../../../../bloc/bloc_consumer_extension.dart';
import '../../../../bloc/bloc_helper.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../utilities/download_management/buttons/download_buttons.dart';
import '../../../../widgets/base_widgets.dart';
import '../../../../widgets/button_widgets.dart';
import '../../../../widgets/tables/filter_table_widget.dart';
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
      child: ExtendedBlocConsumer<OperationClaimCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          List<Map<String, dynamic>>? datas = [];
          if (state is BlocInitial) {
            BlocProvider.of<OperationClaimCubit>(context).getAll();
          }
          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }
          if (state is BlocFailed) {
            return buildOperationClaimTable(context, datas);
          }
          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            datas = state.result;
            return buildOperationClaimTable(context, datas!);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildOperationClaimTable(
      BuildContext context, List<Map<String, dynamic>> datas) {
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
              datas: datas,
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
                (index) => _editOperationClaim(context,
                    datas.firstWhere((element) => element['id'] == index)),
              ],
              infoHover: getInfoHover(
                color: CustomColors.dark.getColor,
                context,
                "Operasyon yetkileri burada listelenmektedir.",
              ),
              utilityButton: DownloadButtons(
                      color: CustomColors.dark.getColor, data: datas)
                  .excelButton(context),
            ),
          ),
        ],
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
