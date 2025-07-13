import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/assets.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/timer_cubit.dart';
import '../../controller/cubits/yoga_stop_watch_cubit.dart';

class YogaStopWatchViewBody extends StatelessWidget {
  const YogaStopWatchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => YogaStopWatchCubit()),
        BlocProvider(create: (context) => TimerCubit(audioPlayer: audioPlayer)),
      ],
      child: const _YogaStopWatchView(),
    );
  }
}

class _YogaStopWatchView extends StatefulWidget {
  const _YogaStopWatchView();

  @override
  State<_YogaStopWatchView> createState() => _YogaStopWatchViewState();
}

class _YogaStopWatchViewState extends State<_YogaStopWatchView> {
  int _selectedHours = 0;
  int _selectedMinutes = 0;
  int _selectedSeconds = 0;
  CountDownController? _countDownController;

  @override
  void initState() {
    super.initState();
    _countDownController = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, timerState) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.boxHeight40), // 40.h
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.stopWatchCircle),
                  ],
                ),
              ],
            ),
            if (timerState is TimerRunning || timerState is TimerPaused)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.01, // 40.h
                right: MediaQuery.of(context).size.width * 0.075,
                child: CircularCountDownTimer(
                  textAlign: TextAlign.end,
                  duration: _selectedHours * 3600 +
                      _selectedMinutes * 60 +
                      _selectedSeconds,
                  initialDuration:
                  timerState is TimerPaused ? timerState.totalSeconds : 0,
                  controller: _countDownController!,
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.46,
                  ringColor: Colors.grey[300]!,
                  fillColor: AppColors.secondaryColor,
                  backgroundColor: Colors.transparent,
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: AppStyles.text14SemiBold.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textFormat: 'HH:mm:ss',

                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: timerState is TimerRunning,
                  autoStart: timerState is TimerRunning,
                  onStart: () {
                    context.read<TimerCubit>().startTimer(
                        _selectedHours, _selectedMinutes, _selectedSeconds);
                  },
                  onComplete: () {
                    context.read<TimerCubit>().finishTimer();
                  },
                ),
              ),
            Positioned(
              top: Dimensions.boxHeight100, // 100.h
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(Assets.stopWatchFullShape),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.09,
              right: MediaQuery.of(context).size.width * 0.1,
              child: BlocBuilder<YogaStopWatchCubit, YogaStopWatchState>(
                builder: (context, stopWatchState) {
                  final stopWatchCubit = context.read<YogaStopWatchCubit>();
                  final displayTime =
                  stopWatchCubit.formatTime(stopWatchState.seconds);

                  final int clockSeconds =
                  (stopWatchState is YogaStopWatchRunning ||
                      stopWatchState is YogaStopWatchPaused)
                      ? stopWatchState.seconds
                      : 0;

                  return Column(
                    children: [
                      SizedBox(height: Dimensions.boxHeight50), // 50.h
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AnalogClock(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.25,
                            isLive: false,
                            datetime: DateTime(2025, 6, 10, 0, 0, clockSeconds),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            hourHandColor: Colors.transparent,
                            minuteHandColor: Colors.transparent,
                            secondHandColor: AppColors.primaryColor,
                            showNumbers: false,
                            showDigitalClock: false,
                            showAllNumbers: true,
                            showSecondHand:
                            timerState is TimerRunning ? false : true,
                            showTicks: true,
                            numberColor: Colors.transparent,
                          ),
                          _buildClockMarkers(context),
                        ],
                      ),
                      SizedBox(height: Dimensions.boxHeight50), // 20.h
                      Text(
                        displayTime,
                        style: AppStyles.text16SemiBold
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: Dimensions.boxHeight60), // 60.h
                      _buildMainControls(context, stopWatchState, timerState),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainControls(BuildContext context,
      YogaStopWatchState stopWatchState, TimerState timerState) {
    final stopWatchCubit = context.read<YogaStopWatchCubit>();
    final timerCubit = context.read<TimerCubit>();

    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    final double spacing = MediaQuery.of(context).size.width * 0.08;
    final double buttonAreaWidth = MediaQuery.of(context).size.width * 0.85;

    void resetAll() {
      if (_countDownController != null) {
        _countDownController!.pause();
      }
      timerCubit.resetTimer();
      stopWatchCubit.reset();
      setState(() {
        _selectedHours = 0;
        _selectedMinutes = 0;
        _selectedSeconds = 0;
      });
    }

    List<Widget> buttons;
    if (timerState is TimerRunning) {
      buttons = [
        _buildIconButton(
          icon: Icons.pause,
          label: S.of(context).pause,
          onPressed: () {
            if (_countDownController != null) {
              _countDownController!.pause();
              timerCubit.pauseTimer();
            }
          },
        ),
        SizedBox(width: spacing),
        _buildIconButton(
          icon: Icons.replay,
          label: S.of(context).reset,
          onPressed: resetAll,
        ),
      ];
    } else if (timerState is TimerPaused) {
      buttons = [
        _buildIconButton(
          icon: Icons.play_arrow,
          label: S.of(context).resume,
          onPressed: () {
            if (_countDownController != null) {
              _countDownController!.resume();
              timerCubit.resumeTimer();
            }
          },
        ),
        SizedBox(width: spacing),
        _buildIconButton(
          icon: Icons.replay,
          label: S.of(context).reset,
          onPressed: resetAll,
        ),
      ];
    } else {
      buttons = [
        _buildIconButton(
          icon: stopWatchState is YogaStopWatchRunning
              ? Icons.pause
              : Icons.play_arrow,
          label: stopWatchState is YogaStopWatchRunning
              ? S.of(context).pause
              : S.of(context).start,
          onPressed: stopWatchCubit.toggleStopwatch,
        ),
        SizedBox(width: spacing),
        _buildIconButton(
          icon: Icons.replay,
          label: S.of(context).reset,
          onPressed: resetAll,
        ),
        SizedBox(width: spacing),
        _buildIconButton(
          icon: Icons.timer,
          label: S.of(context).timer,
          onPressed: () => _showTimerPicker(context),
        ),
      ];
    }

    return Container(
      width: buttonAreaWidth,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: buttons,
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: buttonSize * 0.5,
            color: AppColors.primaryColor,
          ),
          onPressed: onPressed,
          padding: EdgeInsets.all(buttonSize * 0.2),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonSize * 0.2),
              side: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
          ),
        ),
        SizedBox(height: Dimensions.boxHeight4), // 4.h
        Text(
          label,
          style: AppStyles.text14Regular.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _showTimerPicker(BuildContext context) {
    int dialogHours = _selectedHours;
    int dialogMinutes = _selectedMinutes;
    int dialogSeconds = _selectedSeconds;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium), // 25.r
          ),
          title: Center(
            child: Text(
              S.of(context).set_timer,
              style: AppStyles.text16SemiBold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: Dimensions.paddingMedium, // 16.w
                  runSpacing: Dimensions.paddingMedium, // 16.h
                  children: [
                    _buildTimeColumn(
                      label: S.of(context).hours,
                      value: dialogHours,
                      min: 0,
                      max: 23,
                      onChanged: (val) => setDialogState(() => dialogHours = val),
                    ),
                    _buildTimeColumn(
                      label: S.of(context).minutes,
                      value: dialogMinutes,
                      min: 0,
                      max: 59,
                      onChanged: (val) => setDialogState(() => dialogMinutes = val),
                    ),
                    _buildTimeColumn(
                      label: S.of(context).seconds,
                      value: dialogSeconds,
                      min: 0,
                      max: 59,
                      onChanged: (val) => setDialogState(() => dialogSeconds = val),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                S.of(context).cancel,
                style: AppStyles.text14Regular.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall), // 10.r
                ),
              ),
              onPressed: () {
                final totalSeconds =
                    dialogHours * 3600 + dialogMinutes * 60 + dialogSeconds;
                if (totalSeconds > 0) {
                  setState(() {
                    _selectedHours = dialogHours;
                    _selectedMinutes = dialogMinutes;
                    _selectedSeconds = dialogSeconds;
                    _countDownController = CountDownController();
                  });
                  Navigator.pop(dialogContext);
                  if (mounted) {
                    _countDownController!.start();
                    context.read<TimerCubit>().startTimer(
                      dialogHours,
                      dialogMinutes,
                      dialogSeconds,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).please_enter_valid_time,
                        style: AppStyles.text14Regular,
                      ),
                      backgroundColor: Colors.red[400],
                    ),
                  );
                }
              },
              child: Text(
                S.of(context).start,
                style: AppStyles.text14Regular.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppStyles.text14Regular),
        NumberPicker(
          value: value,
          minValue: min,
          maxValue: max,
          textStyle: AppStyles.text12Regular.copyWith(color: Colors.grey),
          selectedTextStyle:
          AppStyles.text14Regular.copyWith(color: AppColors.primaryColor),
          onChanged: onChanged,
          itemWidth: Dimensions.boxHeight50, // 50.w
          itemHeight: Dimensions.boxHeight30, // 30.h
          axis: Axis.vertical,
        ),
      ],
    );
  }

  Widget _buildClockMarkers(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.45,
      child: CustomPaint(
        painter: _ClockMarkerPainter(),
      ),
    );
  }
}

class _ClockMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final markerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const positions = [12, 3, 6, 9];

    for (var hour in positions) {
      final angle = pi / 2 - (hour * pi / 6);
      final markerLength = radius * 0.1;

      canvas.drawLine(
        Offset(
          center.dx + (radius - markerLength) * cos(angle),
          center.dy - (radius - markerLength) * sin(angle),
        ),
        Offset(
          center.dx + radius * cos(angle),
          center.dy - radius * sin(angle),
        ),
        markerPaint,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: hour.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          center.dx + (radius - 15) * cos(angle) - textPainter.width / 2,
          center.dy - (radius - 15) * sin(angle) - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}