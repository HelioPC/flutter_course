import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum BreakType { work, rest }

abstract class _PomodoroStore with Store {
  @observable
  bool started = false;

  @observable
  int min = 2;

  @observable
  int sec = 0;

  @observable
  int workTime = 2;

  @observable
  int restTime = 1;

  @observable
  BreakType breakType = BreakType.work;

  Timer? cronometer;

  @action
  void start() {
    started = true;
    cronometer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (min == 0 && sec == 0) {
        _changeBreakType();
      } else if (sec == 0) {
        sec = 59;
        min--;
      } else {
        sec--;
      }
    });
  }

  @action
  void restart() {
    stop();
    min = isWork() ? workTime : restTime;
    sec = 0;
  }

  @action
  void stop() {
    started = false;
    cronometer?.cancel();
  }

  @action
  void increaseWorkTime() {
    workTime++;
    if (isWork()) {
      restart();
    }
  }

  @action
  void decreaseWorkTime() {
    workTime--;
    if (isWork()) {
      restart();
    }
  }

  @action
  void increaseRestTime() {
    restTime++;
    if (isRest()) {
      restart();
    }
  }

  @action
  void decreaseRestTime() {
    restTime--;
    if (isRest()) {
      restart();
    }
  }

  bool isRest() => breakType == BreakType.rest;

  bool isWork() => breakType == BreakType.work;

  void _changeBreakType() {
    if (isWork()) {
      breakType = BreakType.rest;
      min = restTime;
    } else {
      breakType = BreakType.work;
      min = workTime;
    }
    sec = 0;
  }
}
