import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });
  static final _defaultUser = ChatUser(
    id: '1',
    name: 'Hélio',
    email: 'helio@chat.com',
    image: 'assets/images/avatar.png',
  );

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  ChatUser? get getCurrentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String email,
    String password,
    String name,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      image: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;
}
