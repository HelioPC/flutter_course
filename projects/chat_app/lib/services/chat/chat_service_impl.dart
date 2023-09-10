import 'dart:async';
import 'dart:math';

import 'package:chat_app/model/chat_message.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/chat/chat_service.dart';

class ChatServiceImpl implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'text',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Hélio',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'text',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'André',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'text',
      createdAt: DateTime.now(),
      userId: '789',
      userName: 'Bruno',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((p0) {
    _controller = p0;
    p0.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.image,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs);

    return newMessage;
  }
}
