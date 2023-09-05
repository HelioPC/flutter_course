import 'package:chat_app/services/auth/auth_service_impl.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chat page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthServiceImpl().logout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
