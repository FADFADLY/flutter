import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_entry/monthly_mood_entry_cubit.dart';
import 'calendar_day_widget.dart';

class CalendarBuildersHelper {
  static CalendarBuilders getCalendarBuilders(
      MonthlyMoodEntryCubit cubit, DateTime? selectedDay) {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day: day),
            backgroundColor: AppColors.backgroundColor,
          ),
        );
      },
      selectedBuilder: (context, day, focusedDay) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day: day),
            backgroundColor: AppColors.primaryColor,
            isSelected: true,
          ),
        );
      },
      todayBuilder: (context, day, focusedDay) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
          child: CalendarDayWidget(
            day: day,
            mood: cubit.getDailyMood(day: day),
            backgroundColor: AppColors.backgroundColor,
            isToday: true,
          ),
        );
      },
    );
  }
}