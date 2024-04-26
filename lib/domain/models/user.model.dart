import 'package:neko_coffee/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.fullname,
    required super.email,
    required super.phone,
    required super.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      fullname: map['full_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      uid: map['id'] ?? '',
    );
  }

  UserModel copyWith({
    String? fullname,
    String? email,
    String? phone,
    String? uid,
  }) {
    return UserModel(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
    );
  }
}
