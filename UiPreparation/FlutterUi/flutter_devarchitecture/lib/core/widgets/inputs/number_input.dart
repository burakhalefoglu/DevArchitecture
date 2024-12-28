import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../constants/temp/messages.dart';
import '../../helpers/extensions.dart';

class CustomNumberInput extends TextFormField {
  CustomNumberInput(
      {super.key,
      super.onChanged,
      super.enabled = true,
      required String labelText,
      required String hintText,
      required min,
      required max,
      required super.controller,
      double contentPadding = 20})
      : super(
          validator: (value) {
            if (!enabled!) return null;
            if (value == null || value.isEmpty) {
              return '$labelText ${Messages.cantBeEmpty}';
            }
            if (!value.isValidNumber) {
              return Messages.invalidNumber;
            }
            if (double.parse(value) < double.parse(min.toString())) {
              return "$labelText ${Messages.minimum} $min";
            }
            if (double.parse(value) > double.parse(max.toString())) {
              return "$labelText ${Messages.maximum} $max";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.only(bottom: contentPadding),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
        );
}
