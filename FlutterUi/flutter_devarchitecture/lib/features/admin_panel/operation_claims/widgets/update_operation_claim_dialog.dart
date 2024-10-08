import 'package:flutter/material.dart';
import '../../../../core/theme/extensions.dart';
import '../../../../core/widgets/inputs/text_input.dart';
import '../models/operation_claim_dto.dart';
import '../models/operation_claim.dart';

class UpdateOperationClaimDialog extends StatefulWidget {
  final OperationClaim operationClaim;

  const UpdateOperationClaimDialog({Key? key, required this.operationClaim})
      : super(key: key);

  @override
  _UpdateOperationClaimDialogState createState() =>
      _UpdateOperationClaimDialogState();
}

class _UpdateOperationClaimDialogState
    extends State<UpdateOperationClaimDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _aliasController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController(text: widget.operationClaim.alias);
    _descriptionController =
        TextEditingController(text: widget.operationClaim.description);
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Operasyon Yetkisini Güncelle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: context.percent40Screen,
            height: context.percent15Screen,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: Text("Yetki Adı: ${widget.operationClaim.name}")),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomTextInput(
                    controller: _aliasController,
                    labelText: 'Takma Ad',
                    hintText: 'örn: Admin',
                    min: 2,
                    max: 50,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomTextInput(
                    controller: _descriptionController,
                    labelText: 'Açıklama',
                    hintText: 'örn: Bu yetki tüm erişim izinlerini içerir.',
                    min: 5,
                    max: 200,
                  ),
                ),
              ],
            ),
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
              final updatedOperationClaim = OperationClaimDto(
                id: widget.operationClaim.id,
                alias: _aliasController.text,
                description: _descriptionController.text,
              );
              Navigator.of(context).pop(updatedOperationClaim);
            }
          },
          child: const Text('Güncelle'),
        ),
      ],
    );
  }
}
