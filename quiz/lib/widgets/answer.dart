import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final void Function() onPressed;

  const Answer({super.key, required this.answer, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        child: Text(
          answer,
        ),
      ),
    );
  }
}
