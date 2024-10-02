import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../lookups/widgets/lookup_multi_select_auto_complete.dart';
import '../../lookups/models/lookup.dart';
import '../bloc/user_group_cubit.dart';

class GroupUsersAutocomplete extends StatefulWidget {
  final int groupId;
  final Function(List<int>) onChanged;
  final bool isAllSelected;

  const GroupUsersAutocomplete({
    Key? key,
    required this.groupId,
    required this.onChanged,
    this.isAllSelected = false,
  }) : super(key: key);

  @override
  _GroupUsersAutocompleteState createState() => _GroupUsersAutocompleteState();
}

class _GroupUsersAutocompleteState extends State<GroupUsersAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserGroupCubit(),
      child: BlocConsumer<UserGroupCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<UserGroupCubit>(context)
                .getGroupUsers(widget.groupId);
          }
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          var resultWidget = getResultWidgetByState(state);
          if (resultWidget != null) {
            return resultWidget;
          }
          if (state is BlocSuccess<List<LookUp>>) {
            final options = state.result!
                .map((user) => {'id': user.id, 'label': user.label})
                .toList();
            final List<int> selectedIds = state.result!
                .where((e) => e.isSelected == true)
                .toList()
                .map((e) => int.parse(e.id))
                .toList();
            return LookupMultiSelectAutocomplete(
              isAllSelected: widget.isAllSelected,
              selectedIds: selectedIds,
              valueKey: "label",
              options: options,
              labelText: "Kullanıcılar",
              hintText: "Kullanıcı seçin",
              onChanged: widget.onChanged,
              controller: _controller,
              focusNode: _focusNode,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
