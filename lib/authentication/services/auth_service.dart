import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

  entrarUsuario({required String email, required String senha}) {}

  Future<String?> cadastrarUsuario(
      {required String email,
      required String senha,
      required String nome}) async {
    try {
      UserCredential userCredencial = await _firebaseauth
          .createUserWithEmailAndPassword(email: email, password: senha);

      await userCredencial.user!.updateDisplayName(nome);

      print("Funcionou ate aqui");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mail já está em uso.";
      }
      return e.code;
    }

    return null;
  }
}
