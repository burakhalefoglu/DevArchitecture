import 'package:flutter_devarchitecture/core/models/i_entity.dart';

class OperationClaim implements IEntity {
  @override
  late int id;

  String name;
  String alias;
  String description;

  OperationClaim(
      {required this.name, required this.alias, required this.description});

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "alias": alias, "description": description};
  }

  factory OperationClaim.fromMap(Map<String, dynamic> map) {
    return OperationClaim(
        name: map["name"] ?? "",
        alias: map["alias"] ?? "",
        description: map["description"] ?? "");
  }
}
