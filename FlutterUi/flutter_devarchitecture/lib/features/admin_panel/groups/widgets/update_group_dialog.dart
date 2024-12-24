import 'package:flutter/material.dart';
import '/core/constants/screen_element_constants.dart';

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
      title: Text(ScreenElementConstants.updateGroup),
      content: Form(
        key: _formKey,
        child: CustomTextInput(
          controller: _groupNameController,
          labelText: ScreenElementConstants.groupName,
          hintText: ScreenElementConstants.groupNameHint,
          min: 3,
          max: 50,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(ScreenElementConstants.cancelButton),
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
          child: Text(ScreenElementConstants.updateButton),
        ),
      ],
    );
  }
}
