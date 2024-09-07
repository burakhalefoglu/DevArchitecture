import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../models/translate.dart';
import '../widgets/add_translate_dialog.dart';
import '../widgets/update_translate_dialog.dart';
import '/features/layouts/base_scaffold.dart';
import '../../../../core/di/core_initializer.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/button_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';
import '../bloc/translate_cubit.dart';
import '../models/translate_dto.dart';

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
                      (translateId) => _editTranslate(
                          context,
                          tableData.firstWhere(
                              (element) => element['id'] == translateId)),
                      (translateId) => _confirmDelete(context, translateId)
                    ],
                    infoHover: getInfoHover(
                      context,
                      "Dil çevirileri bu sayfada listelenmektedir.",
                      color: CustomColors.gray.getColor,
                    ),
                    addButton: getAddButton(
                      context,
                      () => _addTranslate(context),
                      color: CustomColors.dark.getColor,
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

  void _addTranslate(BuildContext context) async {
    final newTranslate = await showDialog<Translate>(
      context: context,
      builder: (c) => const AddTranslateDialog(),
    );
    if (newTranslate != null) {
      BlocProvider.of<TranslateCubit>(context).add(newTranslate);
    }
  }

  void _editTranslate(
      BuildContext context, Map<String, dynamic> translateData) async {
    var translate = Translate(
        code: translateData["code"],
        langId: translateData["id"],
        value: translateData["value"]);
    final updatedTranslate = await showDialog<Translate>(
      context: context,
      builder: (c) => UpdateTranslateDialog(translate: translate),
    );
    if (updatedTranslate != null) {
      BlocProvider.of<TranslateCubit>(context).update(updatedTranslate);
    }
  }

  void _confirmDelete(BuildContext context, int translateId) {
    showConfirmationDialog(context, () {
      BlocProvider.of<TranslateCubit>(context).delete(translateId);
    });
  }
}
