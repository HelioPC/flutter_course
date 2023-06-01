import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final void Function() reset;

  const Result({super.key, required this.score, required this.reset});

  String get message {
    if (score > 16) {
      return 'Excellent';
    } else if (score > 12) {
      return 'Good';
    } else if (score > 8) {
      return 'Average';
    } else {
      return 'Bad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
          Text(
            'Your score: $score pts',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Reiniciar',
              ),
            ),
          )
        ],
      ),
    );
  }
}
