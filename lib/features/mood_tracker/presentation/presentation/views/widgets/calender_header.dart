import 'package:intl/intl.dart';
import '../../../../../../core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDate;
  final Function(DateTime) onDateChanged;
  final bool isWeekly;

  const CalendarHeader({
    super.key,
    required this.focusedDate,
    required this.onDateChanged,
    this.isWeekly = false,
  });

  int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(firstDayOfYear).inDays;
    return ((daysDifference + firstDayOfYear.weekday) / 7).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final String displayText = isWeekly
        ? S.of(context).week + getWeekOfYear(focusedDate).toString()
        : DateFormat.MMMM().format(focusedDate);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              if (isWeekly) {
                onDateChanged(
                  focusedDate.subtract(const Duration(days: 7)),
                );
              } else {
                onDateChanged(
                  DateTime(focusedDate.year, focusedDate.month - 1, focusedDate.day),
                );
              }
            },
          ),
          AutoSizeText(
            minFontSize: 0,
            displayText,
            style: AppStyles.text20SemiBold.copyWith(color: AppColors.textColor),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              if (isWeekly) {
                onDateChanged(
                  focusedDate.add(const Duration(days: 7)),
                );
              } else {
                onDateChanged(
                  DateTime(focusedDate.year, focusedDate.month + 1, focusedDate.day),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}