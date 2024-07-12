import 'package:flutter/material.dart';

class CustomTextInput extends TextFormField {
  CustomTextInput(
      {required String labelText,
      required String hintText,
      required int min,
      required int max,
      super.key,
      super.onChanged,
      super.enabled = true,
      required super.controller,
      super.keyboardType,
      super.inputFormatters,
      double contentPadding = 20})
      : super(
          validator: (value) {
            if (!enabled!) return null;
            if (value == null || value.isEmpty) {
              return '$labelText boş bırakılamaz';
            }
            if (value.length < min) {
              return "$labelText minimum $min karakter olmalı";
            }
            if (value.length > max) {
              return "$labelText maximum $max karakter olmalı";
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              contentPadding: EdgeInsets.only(bottom: contentPadding)),
        );
}
