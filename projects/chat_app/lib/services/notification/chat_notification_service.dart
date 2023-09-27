import 'package:chat_app/model/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // Push notification

  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMsg =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void _messageHandler(RemoteMessage? event) {
    if (event == null) return;
    if (event.notification != null) {
      add(ChatNotification(
        title: event.notification?.title ?? 'Not informed',
        body: event.notification?.body ?? 'Not informed',
      ));
    }
  }
}
