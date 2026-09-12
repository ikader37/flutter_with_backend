import 'dart:async';

import 'package:app_test_with_backend/features/login/data/datasource/interfaces/remote_auth_data_source.dart';
import 'package:app_test_with_backend/features/login/data/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final FirebaseAuth _auth ;//= FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  const RemoteAuthDataSourceImpl(this._auth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("LOGIN:::${response.credential?.accessToken}");
      print("access token:${response?.credential?.accessToken}");
      print("token:${response?.credential?.token}");
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final idToken = await user.getIdToken();
        await _storage.write(key: 'token', value: idToken);
      }

      return UserModel(email: email, password: password, name: "");
    } on FirebaseAuthException catch (e) {
      print('Erreur Auth: ${e.code} — ${e.message}');
      switch(e.code){
        case 'weak-password':
          throw Exception("Mot de passe trop court.");
          break;
        case 'email-already-in-use':
          throw Exception("email déjà enregistré");
          break;
        case 'invalid-email':
          throw Exception("Format invalide");
        default:
          throw Exception("Erreur survenue");
      }
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<UserModel> getProfil() async {
    final user=_auth.currentUser;
    if(user!=null){
      final userModel=UserModel(email:user.email??'',
          password: " ",
          name: user.displayName??'');
      return userModel;
    }else{
      throw Exception("Aucun utilisateur connecter");
    }
  }
}
