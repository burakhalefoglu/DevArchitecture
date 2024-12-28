import 'package:flutter/material.dart';
import '../../constants/temp/messages.dart';
import '../../constants/temp/screen_element_constants.dart';

class CustomDateInput extends StatefulWidget {
  final TextEditingController dateController;
  final bool enabled;
  final void Function(DateTime value) onDateChanged;

  const CustomDateInput(
      {super.key,
      required this.dateController,
      required this.onDateChanged,
      this.enabled = true});

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      validator: (value) {
        if (!widget.enabled) return null;
        if (value == null || value.isEmpty) {
          return Messages.dateCantBeEmpty;
        }
        return null;
      },
      controller: widget.dateController,
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(bottom: 20, left: 15),
            child: Icon(Icons.calendar_month),
          ),
          contentPadding: EdgeInsets.only(bottom: 10),
          labelText: ScreenElementConstants.dateHint,
          hintText: ScreenElementConstants.dateTimeFormat),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          keyboardType: TextInputType.datetime,
          cancelText: ScreenElementConstants.cancel,
          confirmText: ScreenElementConstants.ok,
          errorFormatText: Messages.invalidDate,
          errorInvalidText: Messages.invalidDate,
          fieldHintText: ScreenElementConstants.dateHint,
          helpText: ScreenElementConstants.dateHint,
          context: context,
          currentDate: DateTime.now(),
          initialDate: DateTime.now(),
          locale: const Locale("tr", "TR"),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime(DateTime.now().year + 100),
        );

        if (pickedDate != null) {
          setState(() {
            widget.onDateChanged(pickedDate);
            widget.dateController.text = pickedDate.toString();
          });
        } else {}
      },
    );
  }
}
