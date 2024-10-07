import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/base_state.dart';
import '../../../../bloc/bloc_consumer_extension.dart';
import '../../../../bloc/bloc_helper.dart';
import '../../../../theme/extensions.dart';
import '../../../../utilities/download_management/buttons/download_buttons.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../bloc/user_cubit.dart';
import '../models/user.dart';
import '../widgets/add_user_dialog.dart';
import '../widgets/change_password_dialog.dart';
import '../widgets/change_user_claim_dialog.dart';
import '../widgets/change_user_group_dialog.dart';
import '../widgets/update_user_dialog.dart';
import '/core/widgets/tables/filter_table_widget.dart';
import '../../../../widgets/base_widgets.dart';
import '../../../../theme/custom_colors.dart';
import '/core/widgets/button_widgets.dart';
import '../../../layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: ExtendedBlocConsumer<UserCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<UserCubit>(context).getAllUser();
          }
          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }
          if (state is BlocSuccess<List<User>>) {
            print("tableData: " +
                state.result!.map((e) => e.toMap()).toList().toString());
            return buildUserTable(
                context, state.result!.map((e) => e.toMap()).toList());
          }
          return SizedBox.shrink();
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
                "Kullanıcı Listesi",
                subDirection: "Admin Panel",
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: const [
                {"userId": "ID"},
                {"email": "E-posta"},
                {"fullName": "Ad-Soyad"},
                {"status": "Durum"},
                {"mobilePhones": "Telefon"},
                {"address": "Adres"},
                {"notes": "Notlar"},
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
                (userId) => _changePassword(
                      context,
                      datas.firstWhere(
                          (element) => element['userId'] == userId)['userId'],
                    ),
                (userId) => _changeUserClaims(
                      context,
                      datas.firstWhere(
                          (element) => element['userId'] == userId)['userId'],
                    ),
                (userId) => _changeUserGroups(
                      context,
                      datas.firstWhere(
                          (element) => element['userId'] == userId)['userId'],
                    ),
                (userId) => _editUser(
                    context,
                    datas.firstWhere(
                      (element) => element['userId'] == userId,
                    )),
                (userId) => _confirmDelete(context, userId)
              ],
              infoHover: getInfoHover(context, "Kullanıcı bilgilerini düzenle"),
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
