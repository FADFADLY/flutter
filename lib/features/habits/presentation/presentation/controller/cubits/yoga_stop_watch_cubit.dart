import 'dart:async';
import 'package:bloc/bloc.dart';

part 'yoga_stop_watch_state.dart';

class YogaStopWatchCubit extends Cubit<YogaStopWatchState> {
  Timer? _stopwatchTimer;
  int _elapsedSeconds = 0;

  YogaStopWatchCubit() : super(YogaStopWatchInitial());

  // Start or pause stopwatch
  void toggleStopwatch() {
    if (state is YogaStopWatchRunning) {
      _stopwatchTimer?.cancel();
      emit(YogaStopWatchPaused(_elapsedSeconds));
    } else if (state is YogaStopWatchPaused || state is YogaStopWatchInitial) {
      _stopwatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _elapsedSeconds++;
        emit(YogaStopWatchRunning(_elapsedSeconds));
      });
      emit(YogaStopWatchRunning(_elapsedSeconds));
    }
  }

  // Reset stopwatch
  void reset() {
    _stopwatchTimer?.cancel();
    _elapsedSeconds = 0;
    emit(YogaStopWatchInitial());
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> close() {
    _stopwatchTimer?.cancel();
    return super.close();
  }
}