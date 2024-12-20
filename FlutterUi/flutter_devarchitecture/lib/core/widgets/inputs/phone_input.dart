import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              return 'telefon girişi boş bırakılamaz';
            }
            if (!value.isValidPhone) {
              return 'Lütfen geçerli bir telefon numarası giriniz.';
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[],
          decoration: const InputDecoration(
              labelText: 'Telefon numarası',
              hintText: 'örn: 555 555 55 55',
              contentPadding: EdgeInsets.only(bottom: 20)),
        );
}
