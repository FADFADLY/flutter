part of 'yoga_stop_watch_cubit.dart';

abstract class YogaStopWatchState {
  int get seconds;
}

class YogaStopWatchInitial extends YogaStopWatchState {
  @override
  int get seconds => 0;
}

class YogaStopWatchRunning extends YogaStopWatchState {
  final int _seconds;
  YogaStopWatchRunning(this._seconds);

  @override
  int get seconds => _seconds;
}

class YogaStopWatchPaused extends YogaStopWatchState {
  final int _seconds;
  YogaStopWatchPaused(this._seconds);

  @override
  int get seconds => _seconds;
}