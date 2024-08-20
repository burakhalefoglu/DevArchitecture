import 'base/split_input.dart';

/// SERİ - NO
/// "99 xxxxxx"
class CustomVehicleLicenseInput extends SingleSplitInput {
  CustomVehicleLicenseInput(
      {super.key,
      required super.controllers,
      required super.onChange,
      super.enabled = true,
      required super.confirmFocusNodes})
      : super(
            format: 's2 d6',
            labelText: "Araç Ruhsatı",
            hintTexts: ["XX", "000000"]);
}
