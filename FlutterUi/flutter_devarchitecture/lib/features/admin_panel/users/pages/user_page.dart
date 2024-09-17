import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
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
import '../../../../core/di/core_initializer.dart';
import '../../../../core/theme/custom_colors.dart';
import '/core/widgets/button_widgets.dart';
import '/features/layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getErrorMessage(state.message);
          }
        },
        builder: (context, state) {
          // İlk kullanıcı yüklemesi ve yükleme durumları için göstergesi
          if (state is BlocInitial || state is BlocLoading) {
            BlocProvider.of<UserCubit>(context).getAllUser();
            return const Center(child: CircularProgressIndicator());
          }

          // Kullanıcı verilerini işleme
          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<User>>) {
            tableData = state.result!.isNotEmpty
                ? state.result!.map((e) => e.toMap()).toList()
                : [];
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
                      "Kullanıcı Listesi",
                      subDirection: "Admin Panel",
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: FilterTableWidget(
                    datas: tableData,
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
                            tableData.firstWhere((element) =>
                                element['userId'] == userId)['userId'],
                          ),
                      (userId) => _changeUserClaims(
                            context,
                            tableData.firstWhere((element) =>
                                element['userId'] == userId)['userId'],
                          ),
                      (userId) => _changeUserGroups(
                            context,
                            tableData.firstWhere((element) =>
                                element['userId'] == userId)['userId'],
                          ),
                      (userId) => _editUser(
                          context,
                          tableData.firstWhere(
                            (element) => element['userId'] == userId,
                          )),
                      (userId) => _confirmDelete(context, userId)
                    ],
                    infoHover:
                        getInfoHover(context, "Kullanıcı bilgilerini düzenle"),
                    addButton: getAddButton(
                      context,
                      () => _addUser(context),
                      color: CustomColors.white.getColor,
                    ),
                    utilityButton: DownloadButtons(
                            data: state is BlocSuccess<List<User>>
                                ? state.result!.map((nv) => nv.toMap()).toList()
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
      builder: (c) => ChangeUserClaimsDialog(c: context, userId: userId),
    );
  }

  void _changeUserGroups(BuildContext context, int userId) async {
    await showDialog(
      context: context,
      builder: (c) => ChangeUserGroupsDialog(c: context, userId: userId),
    );
  }
}
