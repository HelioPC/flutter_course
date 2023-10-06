import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/cronometer.dart';
import 'package:pomodoro/widgets/time_field.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Cronometer()),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeField(value: 25, title: 'Trabalho'),
                TimeField(value: 5, title: 'Descanso'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
