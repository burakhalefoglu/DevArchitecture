import '../../../../core/models/i_entity.dart';

class LookUp implements IEntity {
  @override
  int id;
  String label;

  LookUp({required this.id, required this.label});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
    };
  }

  @override
  factory LookUp.fromMap(Map<String, dynamic> map) {
    return LookUp(
      id: int.parse(map['id']),
      label: map['label'],
    );
  }
}
