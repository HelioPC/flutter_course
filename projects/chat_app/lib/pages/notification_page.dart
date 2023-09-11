import 'package:chat_app/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Visibility(
        visible: service.count > 0,
        replacement: const Center(
          child: Text('Without notifications'),
        ),
        child: ListView.builder(
          itemCount: service.count,
          itemBuilder: (context, i) {
            return ListTile(
              onTap: () => service.remove(i),
              title: Text(items[i].title),
              subtitle: Text(items[i].body),
            );
          },
        ),
      ),
    );
  }
}
