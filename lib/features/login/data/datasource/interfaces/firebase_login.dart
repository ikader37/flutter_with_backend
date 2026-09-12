import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// S'inscrire — crée un utilisateur dans Firebase Auth
Future<UserCredential> register(String email, String password) async {
  try {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
    // Codes d'erreur typiques :
    // 'weak-password' — mot de passe trop court
    // 'email-already-in-use' — email déjà enregistré
    // 'invalid-email' — format invalide
    // throw Exception("Exception lors de la souscriptio");
  }
}

// Se connecter
Future<UserCredential?> login(String email, String password) async {
  try {
    UserCredential response=await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("CREDENTIAL:${response.credential}");
    return response;
  } on FirebaseAuthException catch (e) {
    print('Erreur Auth: ${e.code}');
    return null;
  }
}

// Se déconnecter
Future<void> logout() => _auth.signOut();