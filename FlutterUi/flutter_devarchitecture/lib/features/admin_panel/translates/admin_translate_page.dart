import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/theme/extensions.dart';
import '../../../core/utilities/download_management/buttons/download_buttons.dart';
import '/features/layouts/base_scaffold.dart';
import '../../../core/di/core_initializer.dart';
import '../../../core/theme/custom_colors.dart';
import '../../../core/widgets/base_widgets.dart';
import '../../../core/widgets/button_widgets.dart';
import '../../../core/widgets/tables/filter_table_widget.dart';
import 'bloc/translate_cubit.dart';
import 'models/translate_dto.dart';

class AdminTranslatePage extends StatelessWidget {
  const AdminTranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslateCubit(),
      child: BlocConsumer<TranslateCubit, BaseState>(
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
            BlocProvider.of<TranslateCubit>(context).getTranslates();
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Çeviri verilerini işleme
          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<TranslateDto>>) {
            tableData = state.result!.isNotEmpty
                ? state.result!
                    .map((translation) => translation.toMap())
                    .toList()
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
                      "Dil Çeviri Listesi",
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
                      {"language": "Dil"},
                      {"value": "Değer"},
                    ],
                    color: CustomColors.light.getColor,
                    utilityButton: DownloadButtons(
                            color: CustomColors.dark.getColor,
                            data: state is BlocSuccess<List<TranslateDto>>
                                ? state.result!.map((nv) => nv.toMap()).toList()
                                : [])
                        .excelButton(context),
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
                    infoHover: getInfoHover(
                      context,
                      "Dil çevirileri bu sayfada listelenmektedir.",
                      color: CustomColors.gray.getColor,
                    ),
                    addButton: getAddButton(
                        context,
                        () => CoreInitializer()
                            .coreContainer
                            .screenMessage
                            .getSuccessMessage("Veri Ekleme"),
                        color: CustomColors.dark.getColor),
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
