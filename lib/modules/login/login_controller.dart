import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import '../../shared/exceptions/auth_exception.dart';
import '../../shared/utils/app_state.dart';

class LoginController {
  final _authService = AuthService();

  User? authUser;

  ValueNotifier<bool> isLogged = ValueNotifier(false);
  ValueNotifier<AppState> state = ValueNotifier(AppState.idle);
  ValueNotifier<String> failure = ValueNotifier('');

  Future<void> authCheck() async {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        authUser = user;

        if (authUser == null) {
          isLogged.value = false;
        } else {
          isLogged.value = true;
        }
      },
    );
  }

  Future<void> signInWithGoogle() async {
    state.value = AppState.loading;
    try {
      await _authService.signInWithGoogle();
      state.value = AppState.success;
    } on AuthException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      state.value = AppState.error;
      failure.value = e.message;
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state.value = AppState.loading;
    try {
      await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      state.value = AppState.success;
    } on AuthException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      state.value = AppState.error;
      failure.value = e.message;
    }
  }
}
