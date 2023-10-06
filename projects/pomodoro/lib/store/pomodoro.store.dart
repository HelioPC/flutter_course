import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

abstract class _PomodoroStore with Store {
  @observable
  int workTime = 2;

  @observable
  int restTime = 1;

  @action
  void increaseWorkTime() => workTime++;

  @action
  void decreaseWorkTime() => workTime--;

  @action
  void increaseRestTime() => restTime++;

  @action
  void decreaseRestTime() => restTime--;
}
