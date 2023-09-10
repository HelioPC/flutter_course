import 'dart:io';

import 'package:chat_app/model/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToMe,
  });

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains('assets/images/avatar.png')) {
      provider = AssetImage(uri.toString());
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      radius: 24,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(12);
    const offBorderRadius = Radius.circular(0);

    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: belongsToMe
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius,
                  topRight: borderRadius,
                  bottomLeft: belongsToMe ? borderRadius : offBorderRadius,
                  bottomRight: belongsToMe ? offBorderRadius : borderRadius,
                ),
              ),
              child: Column(
                crossAxisAlignment: belongsToMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: belongsToMe ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign: belongsToMe ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: belongsToMe ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToMe ? null : 165,
          right: belongsToMe ? 165 : null,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}
