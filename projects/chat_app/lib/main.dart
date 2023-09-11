import 'package:chat_app/pages/auth_or_app_page.dart';
import 'package:chat_app/services/notification/chat_notification_service.dart';

// import 'package:chat_app/pages/auth_page.dart';
// import 'package:chat_app/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatNotificationService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOrAppPage(),
      ),
    );
  }
}
