import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
import '../../../../core/constants/temp/screen_element_constants.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../bloc/user_cubit.dart';
import '../models/user.dart';
import '../widgets/add_user_dialog.dart';
import '../widgets/change_password_dialog.dart';
import '../widgets/change_user_claim_dialog.dart';
import '../widgets/change_user_group_dialog.dart';
import '../widgets/update_user_dialog.dart';
import '/core/widgets/tables/filter_table_widget.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/theme/custom_colors.dart';
import '/core/widgets/button_widgets.dart';
import '../../../../layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: ExtendedBlocConsumer<UserCubit, BaseState>(
        builder: (context, state) {
          List<Map<String, dynamic>>? datas;

          if (state is BlocInitial) {
            BlocProvider.of<UserCubit>(context).getAllUser();
          }

          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocSuccess<List<User>>) {
            datas = state.result!.map((e) => e.toMap()).toList();
          } else if (state is BlocFailed) {
            final previousState = BlocProvider.of<UserCubit>(context).state;
            if (previousState is BlocSuccess<List<User>>) {
              datas = previousState.result!.map((e) => e.toMap()).toList();
            } else {
              datas = [];
            }
          }

          if (datas == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildUserTable(context, datas);
        },
      ),
    );
  }

  Widget buildUserTable(
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
                ScreenElementConstants.userList,
                subDirection: ScreenElementConstants.adminPanel,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: [
                {"userId": "ID"},
                {"email": ScreenElementConstants.email},
                {"fullName": ScreenElementConstants.fullName},
                {"status": ScreenElementConstants.status},
                {"mobilePhones": ScreenElementConstants.mobilePhones},
                {"address": ScreenElementConstants.address},
                {"notes": ScreenElementConstants.notes},
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
                (userId) {
                  var user = datas.firstWhere(
                    (element) => element['userId'] == userId,
                  );
                  _changePassword(context, user['userId']);
                },
                (userId) {
                  var user = datas.firstWhere(
                    (element) => element['userId'] == userId,
                  );
                  _changeUserClaims(context, user['userId']);
                },
                (userId) {
                  var user = datas.firstWhere(
                    (element) => element['userId'] == userId,
                  );
                  _changeUserGroups(context, user['userId']);
                },
                (userId) {
                  var user = datas.firstWhere(
                    (element) => element['userId'] == userId,
                  );
                  _editUser(context, user);
                },
                (userId) => _confirmDelete(context, userId)
              ],
              infoHover: getInfoHover(context, Messages.userInfoHover),
              addButton: getAddButton(
                context,
                () => _addUser(context),
                color: CustomColors.white.getColor,
              ),
              utilityButton: DownloadButtons(
                data: datas,
              ).excelButton(context),
            ),
          ),
        ],
      ),
    );
  }

  void _addUser(BuildContext context) async {
    final newUser = await showDialog<User>(
      context: context,
      builder: (c) => const AddUserDialog(),
    );
    if (newUser != null) {
      BlocProvider.of<UserCubit>(context).add(newUser);
    }
  }

  void _editUser(BuildContext context, Map<String, dynamic> userData) async {
    final updatedUser = await showDialog<User>(
      context: context,
      builder: (c) => UpdateUserDialog(user: User.fromMap(userData)),
    );
    if (updatedUser != null) {
      BlocProvider.of<UserCubit>(context).update(updatedUser);
    }
  }

  void _confirmDelete(BuildContext context, int userId) {
    showConfirmationDialog(context, () {
      BlocProvider.of<UserCubit>(context).delete(userId);
    });
  }

  void _changePassword(BuildContext context, int userId) async {
    final newPassword = await showDialog<String>(
      context: context,
      builder: (c) => ChangeUserPasswordDialog(userId: userId),
    );

    if (newPassword != null && newPassword.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).saveUserPassword(userId, newPassword);
    }
  }

  void _changeUserClaims(BuildContext context, int userId) async {
    await showDialog(
      context: context,
      builder: (c) => ChangeUserClaimsDialog(userId: userId),
    );
  }

  void _changeUserGroups(BuildContext context, int userId) async {
    await showDialog(
      context: context,
      builder: (c) => ChangeUserGroupsDialog(userId: userId),
    );
  }
}
