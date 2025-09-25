import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

  Future<String?> entrarUsuario(
      {required String email, required String senha}) async {
    try {
      await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "O e-mail não está cadastrado.";
        case "invalid-credential":
          return "Senha inválida";
      }
      return e.code;
    }
    return null;
  }

  Future<String?> cadastrarUsuario(
      {required String email,
      required String senha,
      required String nome}) async {
    try {
      UserCredential userCredencial = await _firebaseauth
          .createUserWithEmailAndPassword(email: email, password: senha);

      await userCredencial.user!.updateDisplayName(nome);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mail já está em uso.";
      }
      return e.code;
    }

    return null;
  }

  Future<String?> redefinicaoSenha({required String email}) async {
    try {
      await _firebaseauth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "E-mail não cadastrado";
      }
      return e.code;
    }
    return null;
  }

  Future<String?> deslogar() async {
    try {
      await _firebaseauth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<String?> removerConta() async {
    await _firebaseauth.currentUser!.delete();
  }
}
