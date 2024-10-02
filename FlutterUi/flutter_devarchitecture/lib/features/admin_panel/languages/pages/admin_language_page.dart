import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../bloc/language_cubit.dart';
import '../models/language.dart';
import '../widgets/add_language_dialog.dart';
import '../widgets/update_language_dialog.dart';
import '/features/layouts/base_scaffold.dart';
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
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            // İlk dil verilerini yükle
            BlocProvider.of<LanguageCubit>(context).getAll();
            return const Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> tableData = [];
          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            tableData = state.result!.map((language) => language).toList();
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
                    infoHover:
                        getInfoHover(context, "Diller bu sayfada listelenir."),
                    utilityButton: DownloadButtons(
                            color: CustomColors.dark.getColor,
                            data:
                                state is BlocSuccess<List<Map<String, dynamic>>>
                                    ? state.result!
                                    : [])
                        .excelButton(context),
                    color: CustomColors.danger.getColor,
                    customManipulationButton: const [
                      getEditButton,
                      getDeleteButton
                    ],
                    customManipulationCallback: [
                      (id) => _editLanguage(
                          context,
                          tableData.firstWhere(
                            (element) => element['id'] == id,
                          )),
                      (id) => _confirmDelete(context, id)
                    ],
                    addButton: getAddButton(
                      context,
                      () => _addLanguage(context),
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

  void _addLanguage(BuildContext context) async {
    final newLanguage = await showDialog<Language>(
      context: context,
      builder: (c) => const AddLanguageDialog(),
    );
    if (newLanguage != null) {
      BlocProvider.of<LanguageCubit>(context).add(newLanguage);
    }
  }

  void _editLanguage(
      BuildContext context, Map<String, dynamic> languageData) async {
    final updatedLanguage = await showDialog<Language>(
      context: context,
      builder: (c) =>
          UpdateLanguageDialog(language: Language.fromMap(languageData)),
    );
    if (updatedLanguage != null) {
      BlocProvider.of<LanguageCubit>(context).update(updatedLanguage);
    }
  }

  void _confirmDelete(BuildContext context, int languageId) {
    showConfirmationDialog(context, () {
      BlocProvider.of<LanguageCubit>(context).delete(languageId);
    });
  }
}
