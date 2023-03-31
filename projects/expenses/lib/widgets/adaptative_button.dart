import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(text),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          );
  }
}
