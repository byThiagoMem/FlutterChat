import 'package:chat_flutter/shared/utils/keyboard_dismiss_on_tap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../modules/chat/chat_controller.dart';
import '../../shared/theme/app_text_styles.dart';
import '../../shared/widgets/chat_conversation_tile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

late ChatController _controller;
late TextEditingController _messageController;
late GlobalKey<FormState> _formKey;

var _me = FirebaseAuth.instance.currentUser;

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    _controller = ChatController()..getMessages(id: widget.id);
    _messageController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.id,
            style: AppTextStyles.heading20(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: _controller.messages,
          builder: (_, AsyncSnapshot<List<MessageModel>> snapshot) {
            var messages = snapshot.data ?? [];

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];

                      return ChatConversationTile(
                        isMe: _me?.uid == message.user.id,
                        name: message.user.name,
                        message: message.content,
                        hour: message.time,
                        onLongPress: () => _controller.deleteMessage(
                          chatId: widget.id,
                          messageId: message.id ?? '',
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 14,
          ),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                label: Text(
                  'Digite sua mensagem aqui',
                  style: AppTextStyles.bodyMedium(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: sendMessage,
                  splashRadius: 20,
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      var message = MessageModel(
        id: '',
        content: _messageController.text,
        time: DateTime.now(),
        user: UserModel(
          id: _me?.uid ?? '',
          name: _me?.displayName ?? 'Não identificado',
        ),
      );

      _controller.sendMessages(
        chatId: widget.id,
        message: message,
      );

      _messageController.clear();
    }
  }
}
