import 'package:flutter/material.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/habit_tracker_view.dart';
import 'package:graduationproject/features/test/presentation/views/select_tests.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../blog/presentation/view/blog_view.dart';
import '../../chatbot/presentation/views/chatbot_view.dart';
import '../../community/presentation/view/community_view.dart';
import '../../mood_tracker/presentation/presentation/views/mood_tracker_view.dart';
import '../../mood_tracker/presentation/presentation/views/mood_tracker_view_by_date.dart';
import '../models/grid_item_model.dart';

class GridController {
  List<GridItem> getGridItems(BuildContext context) {
    return [
      GridItem(
        title: S.of(context).tests,
        imagePath: Assets.imagesHomeImg1,
        onPressed: () {
          Navigator.pushNamed(context, SelectTest.routeName);
          print("تم الضغط على زرار tests");
        },
      ),
      GridItem(
        title: S.of(context).chatbot,
        imagePath: Assets.imagesHomeImg2,
        onPressed: () {
          Navigator.pushNamed(context, ChatbotView.routeName);
          print("تم الضغط على زرار chatbot");
        },
      ),
      GridItem(
        title: S.of(context).blog,
        imagePath: Assets.imagesHomeImg3,
        onPressed: () {
          Navigator.pushNamed(context, BlogView.routeName);
          print("تم الضغط على زرار blog");
        },
      ),
      GridItem(
        title: S.of(context).community,
        imagePath: Assets.imagesHomeImg4,
        onPressed: () {
          Navigator.pushNamed(context, CommunityView.routeName);
          print("تم الضغط على زرار community");
        },
      ),
      GridItem(
        title: S.of(context).habits,
        imagePath: Assets.imagesHomeImg5,
        onPressed: () {
          Navigator.pushNamed(context, HabitTrackerView.routeName);
          print("تم الضغط على زرار habits");
        },
      ),
      GridItem(
        title: S.of(context).mood_label,
        imagePath: Assets.imagesHomeImg6,
        onPressed: () {
          Navigator.pushNamed(
              context,
              MoodTrackerViewByDate.routeName
          );; // Assuming MoodTrackerView has a routeName
          print("تم الضغط على زرار mood tracker");
        },
      ),
    ];
  }
}