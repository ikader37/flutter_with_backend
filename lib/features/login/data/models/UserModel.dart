import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String email,
    required String password,
    required String name,
  }) : super(name: name, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'password': password,
    'name': name,
    'email': email,
  };
  UserEntity toEntity() =>
      UserEntity(email: email, name: name, password: password);
}
