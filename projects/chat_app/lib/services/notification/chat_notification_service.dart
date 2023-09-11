import 'package:chat_app/model/chat_notification.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _list = [];

  List<ChatNotification> get items => [..._list];

  int get count => _list.length;

  void add(ChatNotification notification) {
    _list.add(notification);

    notifyListeners();
  }

  void remove(int i) {
    _list.removeAt(i);

    notifyListeners();
  }
}
