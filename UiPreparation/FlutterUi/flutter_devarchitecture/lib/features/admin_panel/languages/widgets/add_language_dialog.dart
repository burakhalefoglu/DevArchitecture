import 'package:flutter/material.dart';
import '../../../../core/constants/temp/messages.dart';
import '/core/constants/temp/screen_element_constants.dart';
import '/core/theme/extensions.dart';
import '../models/language.dart';

class AddLanguageDialog extends StatefulWidget {
  const AddLanguageDialog({Key? key}) : super(key: key);

  @override
  _AddLanguageDialogState createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends State<AddLanguageDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(ScreenElementConstants.addLanguage),
      content: Form(
        key: _formKey,
        child: Container(
          width: context.percent40Screen,
          height: context.percent15Screen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: _codeController,
                  decoration:
                      InputDecoration(labelText: ScreenElementConstants.code),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Messages.cantBeEmpty;
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: ScreenElementConstants.name),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Messages.cantBeEmpty;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
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
              final newLanguage = Language(
                id: 0,
                code: _codeController.text,
                name: _nameController.text,
              );
              Navigator.of(context).pop(newLanguage);
            }
          },
          child: Text(ScreenElementConstants.saveButton),
        ),
      ],
    );
  }
}
