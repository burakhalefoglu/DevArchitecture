import 'package:flutter/material.dart';
import '/core/constants/temp/screen_element_constants.dart';
import '../models/group.dart';
import '../../../../core/widgets/inputs/text_input.dart';

class AddGroupDialog extends StatefulWidget {
  const AddGroupDialog({Key? key}) : super(key: key);

  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _groupNameController;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(ScreenElementConstants.addGroup),
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
          child: Text(ScreenElementConstants.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newGroup = Group(
                id: 0,
                groupName: _groupNameController.text,
              );
              Navigator.of(context).pop(newGroup);
            }
          },
          child: Text(ScreenElementConstants.saveButton),
        ),
      ],
    );
  }
}
