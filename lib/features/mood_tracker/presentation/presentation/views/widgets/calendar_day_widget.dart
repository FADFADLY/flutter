import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';

class CalendarDayWidget extends StatelessWidget {
  final DateTime day;
  final String? mood;
  final Color backgroundColor;
  final bool isSelected;
  final bool isToday;

  const CalendarDayWidget({
    super.key,
    required this.day,
    this.mood,
    required this.backgroundColor,
    this.isSelected = false,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.paddingExtraSmall, horizontal: Dimensions.paddingExtraSmall),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
        ),
        width: Dimensions.pinCodeFieldSize,
        height: Dimensions.boxHeight214,
        padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              minFontSize: 0,
              maxLines: 2,
              softWrap: true,
              '${day.day}',
              style: AppStyles.text14Regular,
            ),
            if (mood != null)
              AutoSizeText(
                minFontSize: 0,
                maxLines: 2,
                softWrap: true,
                mood!,
                style: AppStyles.text12Regular,
              ),
          ],
        ),
      ),
    );
  }
}