import 'dart:io';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/auth/auth_service_impl.dart';

abstract class AuthService {
  ChatUser? get getCurrentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> login(String email, String password);
  Future<void> signup(String email, String password, String name, File? image);
  Future<void> logout();

  factory AuthService() {
    return AuthServiceImpl();
  }
}
