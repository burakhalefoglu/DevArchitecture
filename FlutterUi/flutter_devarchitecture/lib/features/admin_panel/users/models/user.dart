import 'package:flutter_devarchitecture/core/models/i_entity.dart';

class User implements IEntity {
  @override
  int id = 0;
  int userId;
  String fullName;
  String email;
  String address; // nullable
  String notes; // nullable
  bool status;
  String mobilePhones; // nullable

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    this.address = '',
    this.notes = '',
    required this.status,
    this.mobilePhones = '',
  }) {
    id = userId;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as int,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      address: map['address'] ?? '',
      notes: map['notes'] ?? '',
      status: map['status'] as bool,
      mobilePhones: map['mobilePhones'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'address': address,
      'notes': notes,
      'status': status,
      'mobilePhones': mobilePhones,
    };
  }
}
