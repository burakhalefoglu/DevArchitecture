import 'package:flutter/material.dart';

import '../../../../core/widgets/inputs/text_input.dart';
import '../models/group.dart';

class UpdateGroupDialog extends StatefulWidget {
  final Group group;

  const UpdateGroupDialog({Key? key, required this.group}) : super(key: key);

  @override
  _UpdateGroupDialogState createState() => _UpdateGroupDialogState();
}

class _UpdateGroupDialogState extends State<UpdateGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _groupNameController;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController(text: widget.group.groupName);
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Grubu Düzenle'),
      content: Form(
        key: _formKey,
        child: CustomTextInput(
          controller: _groupNameController,
          labelText: 'Grup Adı',
          hintText: 'örn: Yöneticiler',
          min: 3,
          max: 50,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedGroup = Group(
                id: widget.group.id,
                groupName: _groupNameController.text,
              );
              Navigator.of(context).pop(updatedGroup);
            }
          },
          child: const Text('Güncelle'),
        ),
      ],
    );
  }
}
