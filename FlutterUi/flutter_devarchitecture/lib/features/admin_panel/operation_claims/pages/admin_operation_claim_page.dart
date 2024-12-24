import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/screen_element_constants.dart';
import '/core/theme/extensions.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/button_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';
import '../../../../layouts/base_scaffold.dart';
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
        builder: (context, state) {
          List<Map<String, dynamic>>? datas;

          if (state is BlocInitial) {
            BlocProvider.of<OperationClaimCubit>(context).getAll();
          }

          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            datas = state.result;
          } else if (state is BlocFailed) {
            final previousState =
                BlocProvider.of<OperationClaimCubit>(context).state;
            if (previousState is BlocSuccess<List<Map<String, dynamic>>>) {
              datas = previousState.result;
            } else {
              datas = [];
            }
          }

          if (datas == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildOperationClaimTable(context, datas);
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
                ScreenElementConstants.operationClaimList,
                subDirection: ScreenElementConstants.adminPanel,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: [
                {"id": "ID"},
                {"name": ScreenElementConstants.name},
                {"alias": ScreenElementConstants.alias},
                {"description": ScreenElementConstants.description},
              ],
              color: CustomColors.warning.getColor,
              customManipulationButton: const [
                getEditButton,
              ],
              customManipulationCallback: [
                (index) {
                  var operationClaim = datas.firstWhere(
                    (element) => element['id'] == index,
                  );
                  _editOperationClaim(context, operationClaim);
                },
              ],
              infoHover: getInfoHover(
                color: CustomColors.dark.getColor,
                context,
                Messages.operationClaimInfoHover,
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
