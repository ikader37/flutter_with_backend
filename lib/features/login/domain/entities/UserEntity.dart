import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String email;
  final String name;
  final String password;

  const UserEntity({required this.email, required this.name, required this.password});

  UserEntity copyWith({String ? email,String ? name,String ? password}){
    return UserEntity(email: email??this.email,password: password??this.password,name: name??this.name);
  }
}