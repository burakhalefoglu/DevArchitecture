import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/messages.dart';
import '../../constants/screen_element_constants.dart';
import '../../helpers/extensions.dart';

class CustomPhoneInput extends TextFormField {
  CustomPhoneInput({
    super.key,
    super.onChanged,
    required super.controller,
    super.enabled = true,
  }) : super(
          validator: (value) {
            if (!enabled!) return null;
            if (value == null || value.isEmpty) {
              return ScreenElementConstants.phoneNumber + Messages.cantBeEmpty;
            }
            if (!value.isValidPhone) {
              return Messages.invalidPhone;
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[],
          decoration: InputDecoration(
              labelText: ScreenElementConstants.phoneNumber,
              hintText: '+90 999 999 99 99',
              contentPadding: EdgeInsets.only(bottom: 20)),
        );
}
