import '../../../../core/models/i_entity.dart';

class UserGroup implements IEntity {
  @override
  late int id;
  final int groupId;
  final int userId;

  UserGroup({required this.groupId, required this.userId}) {
    this.id = userId;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'userId': userId,
    };
  }

  @override
  factory UserGroup.fromMap(Map<String, dynamic> map) {
    return UserGroup(
      groupId: map['groupId'],
      userId: map['userId'],
    );
  }
}
