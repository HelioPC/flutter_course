import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final user = AuthService().getCurrentUser;

    if (user != null) {
      await ChatService().save(messageController.text, user);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              controller: messageController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                hintText: 'Send something...',
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) {
                if (messageController.text.trim().isNotEmpty) {
                  _sendMessage();
                }
              },
            ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            radius: 25,
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
