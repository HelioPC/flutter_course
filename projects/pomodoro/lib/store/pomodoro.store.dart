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
  BreakType breakType = BreakType.rest;

  @action
  void start() => started = true;

  @action
  void restart() => started = true;

  @action
  void stop() => started = false;

  @action
  void increaseWorkTime() => workTime++;

  @action
  void decreaseWorkTime() => workTime--;

  @action
  void increaseRestTime() => restTime++;

  @action
  void decreaseRestTime() => restTime--;

  bool isRest() => breakType == BreakType.rest;

  bool isWork() => breakType == BreakType.work;
}
