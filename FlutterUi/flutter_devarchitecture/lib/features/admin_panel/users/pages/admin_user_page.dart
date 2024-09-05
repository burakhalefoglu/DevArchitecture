import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/extensions.dart';
import '../bloc/user_cubit.dart';
import '../models/user.dart';
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
          // İlk yükleme ve yükleme durumları için göstergesi
          if (state is BlocInitial || state is BlocLoading) {
            if (state is BlocInitial) {
              BlocProvider.of<UserCubit>(context).getAllUsers();
            }
            return const Center(child: CircularProgressIndicator());
          }

          // Tablo verisi durumu
          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<User>>) {
            tableData = state.result!.isNotEmpty
                ? state.result!.map((user) => user.toMap()).toList()
                : [];
          }

          // Tek bir Scaffold yapısı kullan
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
                    datas: tableData, // Duruma göre dolu veya boş tablo verisi
                    headers: const [
                      {"userId": "Kullanıcı ID"},
                      {"email": "E-posta"},
                      {"fullName": "Ad Soyad"},
                      {"status": "Durum"},
                      {"mobilePhones": "Telefon Numaraları"},
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
}
