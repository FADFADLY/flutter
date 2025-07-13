import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_entry/monthly_mood_entry_cubit.dart';
import 'calendar_builders.dart';
import 'calendar_style.dart';
import 'calender_header.dart';
import 'custom_week_days.dart';

class CalendarWidget extends StatelessWidget {
  final MonthlyMoodEntryCubit cubit;

  const CalendarWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(
          isWeekly: false,
          focusedDate: cubit.newFocusedDay!,
          onDateChanged: (newFocusedDay) {
            cubit.updateNewFocusedDay(newFocusedDay);
            cubit.getMoods(
              month: newFocusedDay.month.toString(),
              year: newFocusedDay.year.toString(),
            );
          },
        ),
        const CustomWeekDays(),
        TableCalendar(
          availableGestures: AvailableGestures.none,
          firstDay: DateTime.utc(2025, 1, 1),
          lastDay: DateTime.utc(2025, 12, 31),
          focusedDay: cubit.newFocusedDay!,
          selectedDayPredicate: (day) => isSameDay(cubit.selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            cubit.updateSelectedDay(selectedDay);
            cubit.updateNewFocusedDay(focusedDay);
          },
          calendarBuilders: CalendarBuildersHelper.getCalendarBuilders(cubit, cubit.selectedDay),
          calendarStyle: CalendarStyleHelper.calendarStyle,
          headerStyle: CalendarStyleHelper.headerStyle,
          daysOfWeekVisible: false,
          headerVisible: false,
          rowHeight: Dimensions.boxHeight214,
        ),
      ],
    );
  }
}