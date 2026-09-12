import 'package:app_test_with_backend/features/login/data/models/UserModel.dart';
import 'package:app_test_with_backend/features/register/data/datasource/interfaces/remote_register_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteRegisterDataSourceImpl implements RemoteRegisterDataSource{

  final FirebaseAuth _auth ;//= FirebaseAuth.instance;

  const RemoteRegisterDataSourceImpl(this._auth);


  @override
  Future<UserCredential> register(String email, String password, String name) async{
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Codes d'erreur typiques :
      // 'weak-password' — mot de passe trop court
      // 'email-already-in-use' — email déjà enregistré
      // 'invalid-email' — format invalide
      print('Erreur Auth: ${e.code} — ${e.message}');
      throw Exception("Erreur survenue");
    }
  }


}