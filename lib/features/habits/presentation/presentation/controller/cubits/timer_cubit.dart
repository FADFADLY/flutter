import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit({required AudioPlayer audioPlayer})
      : _audioPlayer = audioPlayer,
        super(TimerInitial());

  final AudioPlayer _audioPlayer;
  Timer? _timer;
  int _totalSeconds = 0;
  bool _isResetting = false;

  String formatTime(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Future<void> _playAlarm() async {
    try {
      await _audioPlayer.play(AssetSource('audio/bedside-alarm.mp3'));
    } catch (e) {
      print('Error playing alarm: $e');
    }
  }

  void startTimer(int hours, int minutes, int seconds) {
    _timer?.cancel();
    _totalSeconds = hours * 3600 + minutes * 60 + seconds;
    if (_totalSeconds <= 0) {
      emit(TimerInitial());
      return;
    }

    emit(TimerRunning(totalSeconds: _totalSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.isActive && !_isResetting && _totalSeconds > 0) {
        _totalSeconds--;
        emit(TimerRunning(totalSeconds: _totalSeconds));
      } else if (timer.isActive && !_isResetting && _totalSeconds <= 0) {
        timer.cancel();
        finishTimer();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(TimerPaused(totalSeconds: _totalSeconds));
  }

  void resumeTimer() {
    if (_totalSeconds <= 0) {
      emit(TimerFinished());
      return;
    }

    emit(TimerRunning(totalSeconds: _totalSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.isActive && !_isResetting && _totalSeconds > 0) {
        _totalSeconds--;
        emit(TimerRunning(totalSeconds: _totalSeconds));
      } else if (timer.isActive && !_isResetting && _totalSeconds <= 0) {
        timer.cancel();
        finishTimer();
      }
    });
  }

  void finishTimer() {
    _timer?.cancel();
    emit(TimerFinished());
    _playAlarm();
  }

  void resetTimer() {
    _isResetting = true;
    _timer?.cancel(); // Cancel immediately
    _totalSeconds = 0; // Reset seconds before emitting
    emit(TimerInitial());
    _isResetting = false;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}