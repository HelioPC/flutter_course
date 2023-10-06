import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final int value;
  final String title;

  const TimeField({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () {},
              child: const Icon(Icons.arrow_downward),
            ),
            Text(
              '$value min',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () {},
              child: const Icon(Icons.arrow_upward),
            ),
          ],
        ),
      ],
    );
  }
}
