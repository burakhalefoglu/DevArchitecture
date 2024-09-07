import 'package:flutter_devarchitecture/core/models/i_entity.dart';

class OperationClaimDto implements IEntity {
  @override
  late int id;

  String alias;
  String description;

  OperationClaimDto({required this.alias, required this.description});

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "alias": alias, "description": description};
  }

  factory OperationClaimDto.fromMap(Map<String, dynamic> map) {
    return OperationClaimDto(
        alias: map["alias"] ?? "", description: map["description"] ?? "");
  }
}
