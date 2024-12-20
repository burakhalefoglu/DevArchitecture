import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../models/translate.dart';
import '../widgets/add_translate_dialog.dart';
import '../widgets/update_translate_dialog.dart';
import '../../../layouts/base_scaffold.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/button_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';
import '../bloc/translate_cubit.dart';

class AdminTranslatePage extends StatelessWidget {
  const AdminTranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslateCubit(),
      child: ExtendedBlocConsumer<TranslateCubit, BaseState>(
        builder: (context, state) {
          List<Map<String, dynamic>>? datas;

          if (state is BlocInitial) {
            BlocProvider.of<TranslateCubit>(context).getAll();
          }

          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocSuccess<List<Map<String, dynamic>>>) {
            datas = state.result;
          } else if (state is BlocFailed) {
            final previousState =
                BlocProvider.of<TranslateCubit>(context).state;
            if (previousState is BlocSuccess<List<Map<String, dynamic>>>) {
              datas = previousState.result;
            } else {
              datas = [];
            }
          }

          if (datas == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildTranslateTable(context, datas);
        },
      ),
    );
  }

  Widget buildTranslateTable(
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
                "Dil Çeviri Listesi",
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
                {"language": "Dil"},
                {"value": "Değer"},
              ],
              color: CustomColors.light.getColor,
              utilityButton: DownloadButtons(
                      color: CustomColors.dark.getColor, data: datas)
                  .excelButton(context),
              customManipulationButton: const [getEditButton, getDeleteButton],
              customManipulationCallback: [
                (translateId) {
                  var translate = datas.firstWhere(
                    (element) => element['id'] == translateId,
                  );
                  _editTranslate(context, translate);
                },
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
        id: 0,
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
