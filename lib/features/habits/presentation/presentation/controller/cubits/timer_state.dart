part of 'timer_cubit.dart';

abstract class TimerState {
  int get totalSeconds;
}

class TimerInitial extends TimerState {
  @override
  int get totalSeconds => 0;
}

class TimerRunning extends TimerState {
  final int _totalSeconds;

  TimerRunning({required int totalSeconds}) : _totalSeconds = totalSeconds;

  @override
  int get totalSeconds => _totalSeconds;
}

class TimerPaused extends TimerState {
  final int _totalSeconds;

  TimerPaused({required int totalSeconds}) : _totalSeconds = totalSeconds;

  @override
  int get totalSeconds => _totalSeconds;
}

class TimerFinished extends TimerState {
  @override
  int get totalSeconds => 0;
}