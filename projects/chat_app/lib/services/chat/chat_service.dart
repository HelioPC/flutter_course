import 'package:chat_app/model/chat_message.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/chat/chat_service_impl.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();

  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    return ChatServiceImpl();
  }
}
