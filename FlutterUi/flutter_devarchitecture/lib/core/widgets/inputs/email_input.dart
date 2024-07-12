import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/custom_colors.dart';
import 'extensions/extensions.dart';

class CustomEmailInput extends TextFormField {
  CustomEmailInput(
      {required String labelText,
      super.key,
      super.onChanged,
      super.enabled = true,
      required super.controller,
      double contentPadding = 20})
      : super(
          validator: (value) {
            if (!enabled) return null;
            if (value == null || value.isEmpty) {
              return '$labelText boş bırakılamaz';
            }
            if (!value.isValidEmail) {
              return 'Lütfen geçerli bir e-posta adresi giriniz.';
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
              hintText: "örn: abc@example.com",
              labelText: labelText,
              contentPadding: EdgeInsets.only(bottom: contentPadding)),
        );
}
