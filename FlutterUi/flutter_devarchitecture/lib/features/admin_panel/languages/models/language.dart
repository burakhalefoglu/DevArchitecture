import '../../../../core/models/i_entity.dart';

class Language implements IEntity {
  @override
  late int id;
  String code;
  String name;

  Language({
    this.id = 0,
    required this.code,
    required this.name,
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id'],
      code: map['code'] ?? "",
      name: map['name'] ?? "",
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}
