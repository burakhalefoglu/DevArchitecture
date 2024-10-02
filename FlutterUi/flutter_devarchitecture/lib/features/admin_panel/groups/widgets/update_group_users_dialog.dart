import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/features/admin_panel/user-groups/bloc/user_group_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../user-groups/widgets/group_users_auto_complete.dart';

class UpdateGroupUsersDialog extends StatefulWidget {
  final int groupId;

  const UpdateGroupUsersDialog({Key? key, required this.groupId})
      : super(key: key);

  @override
  _UpdateGroupUsersDialogState createState() => _UpdateGroupUsersDialogState();
}

class _UpdateGroupUsersDialogState extends State<UpdateGroupUsersDialog> {
  List<int> _selectedUserIds = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserGroupCubit(),
      child: BlocConsumer<UserGroupCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Grup Kullanıcılarını Güncelle'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: GroupUsersAutocomplete(
                groupId: widget.groupId,
                onChanged: (selectedUserIds) {
                  setState(() {
                    _selectedUserIds = selectedUserIds;
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
                  if (_selectedUserIds.isNotEmpty) {
                    // Grup kullanıcılarını kaydet
                    BlocProvider.of<UserGroupCubit>(context)
                        .saveGroupUsers(widget.groupId, _selectedUserIds);
                    Navigator.of(context).pop();
                  } else {
                    CoreInitializer()
                        .coreContainer
                        .screenMessage
                        .getInfoMessage('Lütfen en az bir kullanıcı seçin.');
                  }
                },
                child: const Text('Güncelle'),
              ),
            ],
          );
        },
      ),
    );
  }
}
