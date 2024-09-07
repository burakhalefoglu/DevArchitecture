import '../../../../core/models/i_entity.dart';

class Translate implements IEntity {
  int langId;
  String code;
  String value;

  @override
  late int id;

  Translate({required this.langId, required this.code, required this.value}) {
    id = langId;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'langId': langId,
      'code': code,
      'value': value,
    };
  }

  factory Translate.fromMap(Map<String, dynamic> map) {
    return Translate(
      langId: map['langId'] ?? 0,
      code: map['code'] ?? "",
      value: map['value'] ?? "",
    );
  }
}
