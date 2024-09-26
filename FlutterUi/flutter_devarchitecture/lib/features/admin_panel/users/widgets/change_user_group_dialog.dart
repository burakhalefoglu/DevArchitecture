import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user-groups/widgets/user_group_auto_complete.dart';
import '../bloc/user_cubit.dart';

class ChangeUserGroupsDialog extends StatefulWidget {
  final int userId; // Kullanıcı ID'si
  final BuildContext c;

  const ChangeUserGroupsDialog(
      {Key? key, required this.c, required this.userId})
      : super(key: key);

  @override
  _ChangeUserGroupsDialogState createState() => _ChangeUserGroupsDialogState();
}

class _ChangeUserGroupsDialogState extends State<ChangeUserGroupsDialog> {
  List<int> _selectedGroups = []; // Seçilen gruplar

  @override
  Widget build(BuildContext context) {
    // Parent cubit'i al
    final userCubit = BlocProvider.of<UserCubit>(widget.c);

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
              userCubit.saveUserGroupPermissions(
                  widget.userId, _selectedGroups);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lütfen en az bir grup seçiniz.'),
                ),
              );
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
