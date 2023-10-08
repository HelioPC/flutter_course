import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:pomodoro/widgets/cronometer_button.dart';
import 'package:provider/provider.dart';

class Cronometer extends StatelessWidget {
  const Cronometer({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Card(
      elevation: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (_) => Text(
              'Hora de ${store.isWork() ? 'trabalhar' : 'descansar'}',
              style: const TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(height: 20),
          Observer(
            builder: (_) => Text(
              '${store.min.toString().padLeft(2, '0')}'
              ':${store.sec.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 120),
            ),
          ),
          const SizedBox(height: 20),
          Observer(
            builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: store.started,
                    replacement: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CronometerButton(
                        onPressed: store.start,
                        icon: Icons.play_arrow,
                        label: 'Start',
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CronometerButton(
                        onPressed: store.stop,
                        icon: Icons.stop,
                        label: 'Stop',
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CronometerButton(
                    onPressed: store.restart,
                    icon: Icons.refresh,
                    label: 'Restart',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
