import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/temp/messages.dart';
import '../../constants/temp/screen_element_constants.dart';
import '../../theme/custom_colors.dart';
import '../../helpers/extensions.dart';

class CustomEmailInput extends TextFormField {
  CustomEmailInput(
      {required BuildContext context,
      super.key,
      super.onChanged,
      super.enabled = true,
      required super.controller,
      double contentPadding = 20})
      : super(
          validator: (value) {
            if (!enabled) return null;
            if (value == null || value.isEmpty) {
              return ScreenElementConstants.email + " " + Messages.cantBeEmpty;
            }
            if (!value.isValidEmail) {
              return Messages.invalidEmail;
            }

            return null;
          },
          inputFormatters: <TextInputFormatter>[],
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                size: 24,
                color: CustomColors.dark.getColor.withAlpha(150),
              ),
              enabled: enabled!,
              hintText: "abc@example.com",
              labelText: ScreenElementConstants.email,
              contentPadding: EdgeInsets.only(bottom: contentPadding)),
        );
}
