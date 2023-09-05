import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/pages/auth_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/services/auth/auth_service_impl.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthServiceImpl().userChanges,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }

          return snap.hasData ? const ChatPage() : const AuthPage();
        },
      ),
    );
  }
}
