import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarStyleHelper {
  static const CalendarStyle calendarStyle = CalendarStyle(
    outsideDaysVisible: false,
    cellMargin: EdgeInsets.zero,
    cellPadding: EdgeInsets.zero,
  );

  static HeaderStyle get headerStyle => HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
    titleTextFormatter: (date, locale) => '',
    leftChevronVisible: false,
    rightChevronVisible: false,
    headerPadding: EdgeInsets.zero,
    headerMargin: EdgeInsets.zero,
  );
}