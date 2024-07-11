import 'base/split_input.dart';

/// Harf ve rakam grupları şöyledir:
/// "99 X 9999", "99 X 99999"
/// "99 XX 999", "99 XX 9999"
/// "99 XXX 99" veya "99 XXX 999"
class VtPlateInput extends SingleSplitInput {
  VtPlateInput({
    super.key,
    required super.controllers,
    required super.onChange,
    required super.confirmFocusNodes,
    super.enabled = true,
    isSimple = false,
  }) : super(
            format: isSimple ? 's15' : 'd2 s3 d5',
            labelText: "Plaka",
            hintTexts: isSimple ? ["XXXXXXXX"] : ["00", "XXX", "00000"]);
}
