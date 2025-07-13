import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../domain/repo/repo.dart';
import '../../controller/cubits/monthly_moods_cubit.dart';
import 'calendar_style.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  static const String routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MonthlyMoodsCubit(moodTrackerRepo: getIt<MoodTrackerRepo>()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MonthlyMoodsCubit, MonthlyMoodsState>(
          builder: (context, state) {
            final cubit = context.read<MonthlyMoodsCubit>();
            final String displayText = false
                ? S.of(context).week + cubit.getWeekOfYear(cubit.focusedDay).toString()
                : DateFormat.MMMM().format(cubit.focusedDay);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          cubit.updateFocusedDay(DateTime(cubit.focusedDay.year, cubit.focusedDay.month - 1, cubit.focusedDay.day));
                        },
                      ),
                      AutoSizeText(
                        minFontSize: 0,
                        displayText,
                        style: AppStyles.text20SemiBold.copyWith(color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          cubit.updateFocusedDay(DateTime(cubit.focusedDay.year, cubit.focusedDay.month + 1, cubit.focusedDay.day));
                        },
                      ),
                    ],
                  ),
                ),
                const CustomWeekDays(),
                // نعرض الكاليندر دايمًا بدون أي رسائل تحميل أو أخطاء
                TableCalendar(
                  availableGestures: AvailableGestures.none,
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: cubit.focusedDay,
                  selectedDayPredicate: (day) => isSameDay(cubit.selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    cubit.updateSelectedDay(selectedDay);
                  },
                  calendarBuilders: CalendarBuildersHelper.getCalendarBuilders(cubit, cubit.selectedDay),
                  calendarStyle: CalendarStyleHelper.calendarStyle,
                  headerStyle: CalendarStyleHelper.headerStyle,
                  daysOfWeekVisible: false,
                  headerVisible: false,
                  rowHeight: Dimensions.boxHeight64,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomWeekDays extends StatelessWidget {
  const CustomWeekDays({super.key});
  @override
  Widget build(BuildContext context) {
    final days = [
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wed,
      S.of(context).thu,
      S.of(context).fri,
      S.of(context).sat,
      S.of(context).sun
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(days.length, (index) {
        BorderRadius borderRadius;
        if (index == 0) {
          borderRadius = const BorderRadius.only(topLeft: Radius.circular(8.0));
        } else if (index == days.length - 1) {
          borderRadius = const BorderRadius.only(topRight: Radius.circular(8.0));
        } else {
          borderRadius = BorderRadius.zero;
        }
        return Expanded(
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: borderRadius,
            ),
            child: Center(
              child: AutoSizeText(
                minFontSize: 0,
                days[index],
                style: AppStyles.text12Bold.copyWith(color: Colors.white),
              ),
            ),
          ),
        );
      }),
    );
  }
}
class CalendarBuildersHelper {
  static CalendarBuilders getCalendarBuilders(dynamic cubit, DateTime? selectedDay) {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day),
            backgroundColor: Colors.grey[200]!,
          ),
        );
      },
      selectedBuilder: (context, day, focusedDay) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day),
            backgroundColor: Colors.blue,
            isSelected: true,
          ),
        );
      },
      todayBuilder: (context, day, focusedDay) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day),
            backgroundColor: Colors.blue[200]!,
            isToday: true,
          ),
        );
      },
    );
  }
}

class CalendarDayWidget extends StatelessWidget {
  final DateTime day;
  final String mood;
  final Color backgroundColor;
  final bool isSelected;
  final bool isToday;

  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.mood,
    required this.backgroundColor,
    this.isSelected = false,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    const Map<String, String> moodEmojis = {
      'none': '\u{1F610}',      // 😐
      'anger': '\u{1F620}',     // 😠
      'joy': '\u{1F604}',       // 😄
      'sadness': '\u{1F622}',   // 😢
      'love': '\u{2764}',       // ❤️
      'fear': '\u{1F628}',      // 😨
      'sympathy': '\u{1F917}',  // 🤗
      'surprise': '\u{1F632}',  // 😲
    };


    final emoji = moodEmojis[mood.toLowerCase()] ?? '';
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${day.day}', style: AppStyles.text14Regular),
            if (emoji.isNotEmpty) Text(emoji, style: AppStyles.text12Regular),
          ],
        ),
      ),
    );
  }
}