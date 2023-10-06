import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/cronometer_button.dart';

class Cronometer extends StatelessWidget {
  const Cronometer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hora de trablhar',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 20),
          Text(
            '25:00',
            style: TextStyle(fontSize: 120),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CronometerButton(icon: Icons.play_arrow, label: 'Start'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CronometerButton(icon: Icons.stop, label: 'Stop'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CronometerButton(icon: Icons.refresh, label: 'Restart'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
