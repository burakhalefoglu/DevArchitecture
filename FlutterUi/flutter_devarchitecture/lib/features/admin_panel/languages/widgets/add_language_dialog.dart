import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/theme/extensions.dart';
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
      title: const Text('Yeni Dil Ekle'),
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
                  decoration: const InputDecoration(labelText: 'Kod'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kod boş bırakılamaz';
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
                  decoration: const InputDecoration(labelText: 'Dil Adı'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dil adı boş bırakılamaz';
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
          child: const Text('İptal'),
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
          child: const Text('Ekle'),
        ),
      ],
    );
  }
}
