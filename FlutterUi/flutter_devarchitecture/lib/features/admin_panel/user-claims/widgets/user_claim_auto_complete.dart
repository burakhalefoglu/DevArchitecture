import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/inputs/custom_multi_select_auto_complete.dart';
import '../bloc/user_claim_cubit.dart';
import '../../../../core/models/lookup.dart';

class UserClaimAutocomplete extends StatefulWidget {
  final int userId;
  final Function(List<int>) onChanged;
  final bool isAllSelected;

  const UserClaimAutocomplete({
    Key? key,
    required this.userId,
    required this.onChanged,
    this.isAllSelected = false,
  }) : super(key: key);

  @override
  _UserClaimAutocompleteState createState() => _UserClaimAutocompleteState();
}

class _UserClaimAutocompleteState extends State<UserClaimAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserClaimCubit(),
      child: BlocConsumer<UserClaimCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            // BlocInitial durumunda kullanıcı yetkilerini yükleyin
            BlocProvider.of<UserClaimCubit>(context)
                .getUserClaimsByUserId(widget.userId);
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlocSuccess<List<LookUp>>) {
            final options = state.result!
                .map((claim) => {'id': claim.id, 'label': claim.label})
                .toList();
            return CustomMultiSelectAutocomplete(
              isAllSelected: widget.isAllSelected,
              valueKey: "label",
              options: options,
              labelText: "Kullanıcı Yetkileri",
              hintText: "Yetki seçin",
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