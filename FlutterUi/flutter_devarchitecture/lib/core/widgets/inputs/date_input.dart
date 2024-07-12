import 'package:flutter/material.dart';

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
          return 'Tarih girişi boş bırakılamaz';
        }
        return null;
      },
      controller: widget.dateController,
      decoration: const InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(bottom: 20, left: 15),
            child: Icon(Icons.calendar_month),
          ),
          contentPadding: EdgeInsets.only(bottom: 10),
          labelText: "Tarih",
          hintText: "örn: 2022-01-01"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            keyboardType: TextInputType.datetime,
            cancelText: "Iptal",
            confirmText: "Tamam",
            errorFormatText: "Geçersiz tarih",
            errorInvalidText: "Geçersiz tarih",
            fieldHintText: "Tarih seçiniz",
            helpText: "Giriş Tarihi",
            context: context,
            currentDate: DateTime.now(),
            initialDate: DateTime.now(),
            locale: const Locale("tr", "TR"),
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime.now());

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
