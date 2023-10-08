import 'package:flutter/material.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:pomodoro/widgets/cronometer.dart';
import 'package:pomodoro/widgets/time_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: Cronometer()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeField(
                      inc: store.isWork() && store.started
                          ? null
                          : store.increaseWorkTime,
                      dec: store.isWork() && store.started
                          ? null
                          : store.decreaseWorkTime,
                      value: store.workTime,
                      title: 'Trabalho',
                    ),
                    TimeField(
                      inc: store.isRest() && store.started
                          ? null
                          : store.increaseRestTime,
                      dec: store.isRest() && store.started
                          ? null
                          : store.decreaseRestTime,
                      value: store.restTime,
                      title: 'Descanso',
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
