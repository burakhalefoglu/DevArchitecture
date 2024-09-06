import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/extensions.dart';
import '../bloc/language_cubit.dart';
import '/features/layouts/base_scaffold.dart';
import '../../../../core/di/core_initializer.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/button_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';

class AdminLanguagePage extends StatelessWidget {
  const AdminLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocConsumer<LanguageCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getErrorMessage(state.message);
          }
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            // İlk dil verilerini yükle
            BlocProvider.of<LanguageCubit>(context).getAll();
            return const Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            tableData = state.result!.isNotEmpty
                ? state.result!.map((language) => language).toList()
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
                      "Diller Listesi",
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
                      {"code": "Kod"},
                      {"name": "Dil Adı"},
                    ],
                    color: CustomColors.danger.getColor,
                    customManipulationButton: const [
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
                                .getErrorMessage(index.toString())
                          }
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
