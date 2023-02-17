import 'dart:developer';

import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import '../../shared/exceptions/auth_exception.dart';
import '../../shared/utils/app_state.dart';

class SignupController {
  final _authService = AuthService();

  ValueNotifier<bool> isSuccess = ValueNotifier(false);
  ValueNotifier<AppState> state = ValueNotifier(AppState.idle);
  ValueNotifier<String> failure = ValueNotifier('');

  Future<void> authCheck() async {}

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state.value = AppState.loading;
    try {
      await _authService.signUpWithEmail(
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
