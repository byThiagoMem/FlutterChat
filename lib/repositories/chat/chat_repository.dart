import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message_model.dart';
import '../../shared/exceptions/chat_exception.dart';

class ChatRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<String>> getChats() async {
    try {
      var response = await db.collection('chats').get();

      return response.docs.map((e) => e.id).toList();
    } catch (e, s) {
      log('Falha ao buscar chats', error: e, stackTrace: s);
      throw ChatException(message: 'Falha ao buscar chats');
    }
  }

  Stream<List<MessageModel>> getMessages({required String id}) {
    try {
      return db
          .collection('chats')
          .doc(id)
          .collection('messages')
          .orderBy('time', descending: true)
          .snapshots()
          .transform(
        StreamTransformer.fromHandlers(
          handleData: (value, sink) {
            if (value.docs.isNotEmpty) {
              var event = value.docs.map(
                (message) => MessageModel.fromJson(message.data()).copyWith(
                  id: message.id,
                ),
              );
              sink.add(event.toList());
            }
          },
        ),
      );
    } catch (e, s) {
      log('Falha ao buscar mensagens', error: e, stackTrace: s);
      throw ChatException(message: 'Falha ao buscar mensagens');
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    try {
      await db
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());
    } catch (e, s) {
      log('Falha ao buscar chats', error: e, stackTrace: s);
      throw Exception('Erro ao criar chat');
    }
  }

  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      await db
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e, s) {
      log('Falha ao deletar mensagem', error: e, stackTrace: s);
      throw ChatException(message: 'Falha ao deletar mensagem');
    }
  }
}
