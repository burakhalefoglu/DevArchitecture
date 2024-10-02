import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../core/di/core_initializer.dart';
import '../../lookups/widgets/lookup_multi_select_auto_complete.dart';
import '../../lookups/models/lookup.dart';
import '../bloc/user_group_cubit.dart';

class UserGroupAutocomplete extends StatefulWidget {
  final int userId;
  final Function(List<int>) onChanged;
  final bool isAllSelected;

  const UserGroupAutocomplete({
    Key? key,
    required this.userId,
    required this.onChanged,
    this.isAllSelected = false,
  }) : super(key: key);

  @override
  _UserGroupAutocompleteState createState() => _UserGroupAutocompleteState();
}

class _UserGroupAutocompleteState extends State<UserGroupAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserGroupCubit(),
      child: BlocConsumer<UserGroupCubit, BaseState>(
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
            // BlocInitial durumunda kullanıcı gruplarını yükleyin
            BlocProvider.of<UserGroupCubit>(context)
                .getUserGroupPermissions(widget.userId);
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocSuccess<List<LookUp>>) {
            final options = state.result!
                .map((group) => {'id': group.id, 'label': group.label})
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
              labelText: "Kullanıcı Grupları",
              hintText: "Grup seçin",
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
