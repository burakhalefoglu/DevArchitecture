import 'package:flutter/material.dart';
import '/core/constants/temp/screen_element_constants.dart';
import '/core/theme/extensions.dart';
import '../../../../core/widgets/inputs/date_input.dart';
import '../../../../core/widgets/inputs/dropdown_button.dart';
import '../../../../core/widgets/inputs/email_input.dart';
import '../../../../core/widgets/inputs/phone_input.dart';
import '../../../../core/widgets/inputs/text_input.dart';
import '../models/user.dart';

class UpdateUserDialog extends StatefulWidget {
  final User user;

  const UpdateUserDialog({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateUserDialogState createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _statusController;
  late TextEditingController _mobilePhonesController;
  late TextEditingController _addressController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user.email);
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _statusController = TextEditingController(
        text: widget.user.status == true
            ? ScreenElementConstants.active
            : ScreenElementConstants.inactive);
    _mobilePhonesController =
        TextEditingController(text: widget.user.mobilePhones);
    _addressController = TextEditingController(text: widget.user.address);
    _notesController = TextEditingController(text: widget.user.notes);
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _statusController.dispose();
    _mobilePhonesController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(ScreenElementConstants.updateUsers),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.percent60Screen,
            height: context.percent60Screen,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomEmailInput(
                    controller: _emailController,
                    context: context,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomTextInput(
                    controller: _fullNameController,
                    labelText: ScreenElementConstants.fullName,
                    hintText: ScreenElementConstants.fullNameHint,
                    min: 3,
                    max: 50,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomDropdownButton(
                    options: [
                      ScreenElementConstants.active,
                      ScreenElementConstants.inactive
                    ],
                    onChanged: (value) {
                      _statusController.text =
                          value ?? ScreenElementConstants.active;
                    },
                    getFirstValue: (value) {
                      _statusController.text =
                          value ?? ScreenElementConstants.active;
                    },
                    icon: Icons.list,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomPhoneInput(
                    controller: _mobilePhonesController,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomTextInput(
                    controller: _addressController,
                    labelText: ScreenElementConstants.address,
                    hintText: ScreenElementConstants.addressHint,
                    min: 10,
                    max: 100,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomTextInput(
                    controller: _notesController,
                    labelText: ScreenElementConstants.notes,
                    hintText: ScreenElementConstants.notesHint,
                    min: 0,
                    max: 200,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: CustomDateInput(
                    dateController: _dateController,
                    onDateChanged: (value) {
                      _dateController.text = value.toIso8601String();
                    },
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
          child: Text(ScreenElementConstants.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedUser = User(
                id: widget.user.id,
                userId: widget.user.id,
                email: _emailController.text,
                fullName: _fullNameController.text,
                status: _statusController.text == ScreenElementConstants.active
                    ? true
                    : false,
                mobilePhones: _mobilePhonesController.text,
                address: _addressController.text,
                notes: _notesController.text,
              );
              Navigator.of(context).pop(updatedUser);
            }
          },
          child: Text(ScreenElementConstants.updateButton),
        ),
      ],
    );
  }
}
