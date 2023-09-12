import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/pages/auth_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/services/auth/auth_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }

        return StreamBuilder<ChatUser?>(
          stream: AuthServiceImpl().userChanges,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }

            return snap.hasData ? const ChatPage() : const AuthPage();
          },
        );
      },
    );
  }
}
