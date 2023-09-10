import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().getCurrentUser;

    return StreamBuilder(
      stream: ChatService().messagesStream(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snap.hasData || snap.data!.isEmpty) {
          return const Center(
            child: Text('Sem mensagens. Vamos conversar?'),
          );
        }

        final msgs = snap.data!;

        return ListView.builder(
          reverse: true,
          itemCount: msgs.length,
          itemBuilder: (context, i) {
            return MessageBubble(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToMe: currentUser?.id == msgs[i].userId,
            );
          },
        );
      },
    );
  }
}
