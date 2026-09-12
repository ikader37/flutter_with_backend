import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteRegisterDataSource {
  Future<UserCredential> register(String email, String password,String name);
}
