import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/base_state.dart';
import '../../../../bloc/bloc_consumer_extension.dart';
import '../../../../bloc/bloc_helper.dart';
import '../../../../theme/extensions.dart';
import '../../../../utilities/download_management/buttons/download_buttons.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../bloc/language_cubit.dart';
import '../models/language.dart';
import '../widgets/add_language_dialog.dart';
import '../widgets/update_language_dialog.dart';
import '../../../layouts/base_scaffold.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../widgets/base_widgets.dart';
import '../../../../widgets/button_widgets.dart';
import '../../../../widgets/tables/filter_table_widget.dart';

class AdminLanguagePage extends StatelessWidget {
  const AdminLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: ExtendedBlocConsumer<LanguageCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          List<Map<String, dynamic>>? datas = [];
          if (state is BlocInitial) {
            BlocProvider.of<LanguageCubit>(context).getAll();
          }
          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocFailed) {
            return buildLanguageTable(context, datas);
          }

          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            datas = state.result;
            return buildLanguageTable(context, datas!);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildLanguageTable(
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
                "Diller Listesi",
                subDirection: "Admin Panel",
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: const [
                {"id": "ID"},
                {"code": "Kod"},
                {"name": "Dil Adı"},
              ],
              infoHover: getInfoHover(context, "Diller bu sayfada listelenir."),
              utilityButton: DownloadButtons(
                      color: CustomColors.dark.getColor, data: datas)
                  .excelButton(context),
              color: CustomColors.danger.getColor,
              customManipulationButton: const [getEditButton, getDeleteButton],
              customManipulationCallback: [
                (id) => _editLanguage(
                    context,
                    datas.firstWhere(
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
