import 'package:flutter/material.dart';
import '../models/language.dart';

class UpdateLanguageDialog extends StatefulWidget {
  final Language language;

  const UpdateLanguageDialog({Key? key, required this.language})
      : super(key: key);

  @override
  _UpdateLanguageDialogState createState() => _UpdateLanguageDialogState();
}

class _UpdateLanguageDialogState extends State<UpdateLanguageDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.language.code);
    _nameController = TextEditingController(text: widget.language.name);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dili Güncelle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Kod'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kod boş bırakılamaz';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Dil Adı'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Dil adı boş bırakılamaz';
                }
                return null;
              },
            ),
          ],
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
              final updatedLanguage = Language(
                id: widget.language.id,
                code: _codeController.text,
                name: _nameController.text,
              );
              Navigator.of(context).pop(updatedLanguage);
            }
          },
          child: const Text('Güncelle'),
        ),
      ],
    );
  }
}
