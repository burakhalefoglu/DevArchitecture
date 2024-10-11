import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devarchitecture/core/helpers/translate_provider_extension.dart';
import '../../theme/custom_colors.dart';
import 'extensions/extensions.dart';

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
              return context.translationProvider.translate("EmailCantBeEmpty");
            }
            if (!value.isValidEmail) {
              return context.translationProvider.translate("InvalidEmail");
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
              labelText: context.translationProvider.translate("Email"),
              contentPadding: EdgeInsets.only(bottom: contentPadding)),
        );
}
