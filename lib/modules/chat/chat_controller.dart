import 'dart:developer';

import '../../models/message_model.dart';
import '../../repositories/chat/chat_repository.dart';

class ChatController {
  final _repository = ChatRepository();

  late Stream<List<MessageModel>> messages;

  void getMessages({required String id}) {
    try {
      var response = _repository.getMessages(id: id);
      messages = response;
    } catch (e, s) {
      log('Falha ao carregar mensagens', error: e, stackTrace: s);
      throw Exception('Falha ao carregar mensagens');
    }
  }

  void sendMessages({
    required String chatId,
    required MessageModel message,
  }) {
    try {
      _repository.sendMessage(
        chatId: chatId,
        message: message,
      );
    } catch (e, s) {
      log('Falha ao carregar mensagens', error: e, stackTrace: s);
      throw Exception('Falha ao carregar mensagens');
    }
  }

  void deleteMessage({
    required String chatId,
    required String messageId,
  }) {
    try {
      _repository.deleteMessage(
        chatId: chatId,
        messageId: messageId,
      );
    } catch (e, s) {
      log('Falha ao carregar mensagens', error: e, stackTrace: s);
      throw Exception('Falha ao carregar mensagens');
    }
  }
}
