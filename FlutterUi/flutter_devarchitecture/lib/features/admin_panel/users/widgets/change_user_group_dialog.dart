import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/di/core_initializer.dart';
import '../../user-groups/bloc/user_group_cubit.dart';
import '../../user-groups/widgets/user_group_auto_complete.dart';

class ChangeUserGroupsDialog extends StatefulWidget {
  final int userId;

  const ChangeUserGroupsDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ChangeUserGroupsDialogState createState() => _ChangeUserGroupsDialogState();
}

class _ChangeUserGroupsDialogState extends State<ChangeUserGroupsDialog> {
  List<int> _selectedGroups = []; // Seçilen gruplar

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
          if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return AlertDialog(
            title: const Text('Kullanıcı Gruplarını Güncelle'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: UserGroupAutocomplete(
                userId: widget.userId,
                onChanged: (selectedGroups) {
                  setState(() {
                    _selectedGroups = selectedGroups;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedGroups.isNotEmpty) {
                    BlocProvider.of<UserGroupCubit>(context)
                        .saveUserGroupPermissions(
                            widget.userId, _selectedGroups);
                    Navigator.of(context).pop();
                  } else {
                    CoreInitializer()
                        .coreContainer
                        .screenMessage
                        .getErrorMessage('Lütfen en az bir grup seçiniz.');
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          );
        },
      ),
    );
  }
}
