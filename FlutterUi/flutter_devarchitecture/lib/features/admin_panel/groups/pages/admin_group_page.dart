import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../../core/theme/extensions.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../widgets/add_group_dialog.dart';
import '../widgets/update_group_claims_dialog.dart';
import '../widgets/update_group_dialog.dart';
import '../widgets/update_group_users_dialog.dart';
import '/core/widgets/tables/filter_table_widget.dart';
import '../../../../../core/widgets/base_widgets.dart';
import '../../../../../core/theme/custom_colors.dart';
import '../../../../../core/widgets/button_widgets.dart';
import '/features/layouts/base_scaffold.dart';
import '/core/widgets/confirmation_dialog.dart';
import '../bloc/group_cubit.dart';
import '../models/group.dart';

class AdminGroupPage extends StatelessWidget {
  const AdminGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupCubit(),
      child: BlocConsumer<GroupCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<GroupCubit>(context).getAll();
          }
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          var resultWidget = getResultWidgetByState(context, state);
          if (resultWidget != null) {
            return resultWidget;
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
                      "Gruplar Listesi",
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
                      {"groupName": "Grup Adı"},
                    ],
                    color: CustomColors.primary.getColor,
                    customManipulationButton: const [
                      updateGroupClaimButton,
                      updateUserGroupButton,
                      getEditButton,
                      getDeleteButton
                    ],
                    customManipulationCallback: [
                      (index) => _updateGroupClaims(
                          context,
                          tableData
                              .firstWhere((element) => element['id'] == index)),
                      (index) => _updateGroupUsers(
                          context,
                          tableData
                              .firstWhere((element) => element['id'] == index)),
                      (index) => _editGroup(
                          context,
                          tableData
                              .firstWhere((element) => element['id'] == index)),
                      (index) => _confirmDelete(context, index)
                    ],
                    addButton: getAddButton(
                      context,
                      () => _addGroup(context),
                      color: CustomColors.white.getColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addGroup(BuildContext context) async {
    final newGroup = await showDialog<Group>(
      context: context,
      builder: (c) => const AddGroupDialog(),
    );
    if (newGroup != null) {
      BlocProvider.of<GroupCubit>(context).add(newGroup);
    }
  }

  void _editGroup(BuildContext context, Map<String, dynamic> groupData) async {
    final updatedGroup = await showDialog<Group>(
      context: context,
      builder: (c) => UpdateGroupDialog(group: Group.fromMap(groupData)),
    );
    if (updatedGroup != null) {
      BlocProvider.of<GroupCubit>(context).update(updatedGroup);
    }
  }

  void _updateGroupUsers(
      BuildContext context, Map<String, dynamic> groupData) async {
    await showDialog(
      context: context,
      builder: (c) => UpdateGroupUsersDialog(groupId: groupData['id']),
    );
  }

  void _updateGroupClaims(
      BuildContext context, Map<String, dynamic> groupData) async {
    await showDialog(
      context: context,
      builder: (c) => UpdateGroupClaimsDialog(groupId: groupData['id']),
    );
  }

  void _confirmDelete(BuildContext context, int groupId) {
    showConfirmationDialog(context, () {
      BlocProvider.of<GroupCubit>(context).delete(groupId);
    });
  }
}
