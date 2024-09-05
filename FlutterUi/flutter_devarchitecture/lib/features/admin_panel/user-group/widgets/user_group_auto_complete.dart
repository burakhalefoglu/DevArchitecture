import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/inputs/custom_multi_select_auto_complete.dart';
import '../../user-claims/models/lookup.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            // BlocInitial durumunda kullanıcı gruplarını yükleyin
            BlocProvider.of<UserGroupCubit>(context)
                .getUserGroupsByUserId(widget.userId);
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocSuccess<List<LookUp>>) {
            final options = state.result!
                .map((group) => {'id': group.id, 'label': group.label})
                .toList();
            return CustomMultiSelectAutocomplete(
              isAllSelected: widget.isAllSelected,
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
