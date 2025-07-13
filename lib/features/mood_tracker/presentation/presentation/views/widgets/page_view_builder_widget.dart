import 'package:flutter/material.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/chart.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/notes.dart';
import 'calendar.dart';
import 'calender_widget.dart';

class PageViewBuilderWidget extends StatelessWidget {
  final PageController pageController;

  const PageViewBuilderWidget({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Calendar();
          } else if (index == 1) {
            return const Chart();
          } else {
            return const Notes();
          }
        },
      ),
    );
  }
}