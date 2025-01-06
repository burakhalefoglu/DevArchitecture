import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/temp/screen_element_constants.dart';
import '/core/widgets/button_widgets.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/theme/custom_colors.dart';
import '../../../../core/utilities/download_management/buttons/download_buttons.dart';
import '../../../../core/widgets/base_widgets.dart';
import '../../../../core/widgets/tables/filter_table_widget.dart';
import '../../../../layouts/base_scaffold.dart';
import 'bloc/log_cubit.dart';
import 'models/log_dto.dart';

class AdminLogPage extends StatelessWidget {
  const AdminLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogCubit(),
      child: ExtendedBlocConsumer<LogCubit, BaseState>(
        builder: (context, state) {
          List<Map<String, dynamic>>? datas;

          if (state is BlocInitial) {
            BlocProvider.of<LogCubit>(context).getLogs();
          }

          var resultWidget = getResultWidgetByStateWithScaffold(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          if (state is BlocSuccess<List<LogDto>>) {
            datas = state.result!.map((e) => e.toMap()).toList();
          } else if (state is BlocFailed) {
            final previousState = BlocProvider.of<LogCubit>(context).state;
            if (previousState is BlocSuccess<List<LogDto>>) {
              datas = previousState.result!.map((e) => e.toMap()).toList();
            } else {
              datas = [];
            }
          }

          if (datas == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildLogTable(context, datas);
        },
      ),
    );
  }

  Widget buildLogTable(BuildContext context, List<Map<String, dynamic>> datas) {
    return buildBaseScaffold(
      context,
      Column(
        children: [
          Expanded(
            child: Padding(
              padding: context.defaultHorizontalPadding,
              child: buildPageTitle(
                context,
                ScreenElementConstants.logList,
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
                {"level": ScreenElementConstants.level},
                {"exceptionMessage": ScreenElementConstants.exceptionMessage},
                {"timeStamp": ScreenElementConstants.timeStamp},
                {"user": ScreenElementConstants.user},
                {"value": ScreenElementConstants.value},
                {"type": ScreenElementConstants.type},
              ],
              color: CustomColors.success.getColor,
              customManipulationButton: const [],
              customManipulationCallback: [],
              infoHover: getInfoHover(context, Messages.logInfoHover),
              utilityButton: DownloadButtons(data: datas).excelButton(context),
            ),
          ),
        ],
      ),
    );
  }
}
