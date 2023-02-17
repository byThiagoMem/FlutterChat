import 'dart:developer';

import 'package:flutter/material.dart';

import '../../repositories/chat/chat_repository.dart';
import '../../services/auth/auth_service.dart';
import '../../shared/exceptions/chat_exception.dart';
import '../../shared/utils/app_state.dart';

class HomeController {
  final _repository = ChatRepository();
  final _authService = AuthService();

  ValueNotifier<AppState> state = ValueNotifier(AppState.idle);
  ValueNotifier<List<String>> chats = ValueNotifier([]);
  ValueNotifier<bool> loggedOut = ValueNotifier(false);
  ValueNotifier<String> failure = ValueNotifier('');

  Future<void> getChats() async {
    try {
      var response = await _repository.getChats();
      chats.value = response;
    } on ChatException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      state.value = AppState.error;
      failure.value = e.message;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    loggedOut.value = true;
  }
}
