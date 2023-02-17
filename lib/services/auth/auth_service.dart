import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../shared/exceptions/auth_exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: ['profile', 'email'],
      ).signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleUser != null) {
        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } on PlatformException catch (e) {
      if (e.code == 'network_error') {
        throw AuthException(message: 'Sem conexão!');
      } else {
        throw AuthException(message: 'Erro ao realizar login!');
      }
    } catch (_) {
      throw AuthException(message: 'Erro ao realizar login!');
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthException(message: 'Ops, não encontramos esse usuário');
        case 'wrong-password':
          throw AuthException(message: 'Email ou senha incorretos!');
        case 'network-request-failed':
          throw AuthException(message: 'Sem conexão!');
        default:
          throw AuthException(
            message:
                'Não conseguimos concluir seu login. Tente de novo mais tarde.',
          );
      }
    }
  }

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException(message: 'E-mail inválido!');
        case 'weak-password':
          throw AuthException(message: 'A senha é muito fraca!');
        case 'email-already-in-use':
          throw AuthException(message: 'Email já cadastrado!');
        case 'network-request-failed':
          throw AuthException(message: 'Sem conexão!');
        default:
          throw AuthException(
            message:
                'Hm, não conseguimos concluir seu cadastro. Tente de novo mais tarde.',
          );
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
