import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/screen_element_constants.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/messages.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../bloc/language_cubit.dart';
import '../models/language.dart';
import '../widgets/add_language_dialog.dart';
import '../widgets/update_language_dialog.dart';
import '../../../layouts/base_scaffold.dart';
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
      child: ExtendedBlocConsumer<LanguageCubit, BaseState>(
        builder: (context, state) {
          List<Map<String, dynamic>>? datas;

          if (state is BlocInitial) {
            BlocProvider.of<LanguageCubit>(context).getAll();
          }

          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            datas = state.result;
          } else if (state is BlocFailed) {
            final previousState = BlocProvider.of<LanguageCubit>(context).state;
            if (previousState is BlocSuccess<List<Map<String, dynamic>>>) {
              datas = previousState.result;
            } else {
              datas = [];
            }
          }

          if (datas == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildLanguageTable(context, datas);
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
                ScreenElementConstants.languageList,
                subDirection: ScreenElementConstants.adminPanel,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FilterTableWidget(
              datas: datas,
              headers: [
                {"id": "ID"},
                {"code": ScreenElementConstants.code},
                {"name": ScreenElementConstants.name},
              ],
              infoHover: getInfoHover(context, Messages.languageInfoHover),
              utilityButton: DownloadButtons(
                      color: CustomColors.dark.getColor, data: datas)
                  .excelButton(context),
              color: CustomColors.danger.getColor,
              customManipulationButton: const [getEditButton, getDeleteButton],
              customManipulationCallback: [
                (id) {
                  var language = datas.firstWhere(
                    (element) => element['id'] == id,
                  );
                  _editLanguage(context, language);
                },
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
