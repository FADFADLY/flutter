import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/relaxation_card.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../books/presentation/view/book_view.dart';
import '../../../../../podcasts/presentation/view/podcasts_view.dart';
import '../yoga_stop_watch_view.dart';

class RelaxationViewBody extends StatelessWidget {
  const RelaxationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(Dimensions.paddingMedium), // 16.w
        children: [
          RelaxationCard(
            assetsPath: Assets.habitTrackerYoga,
            title: S.of(context).yoga_and_breathing_exercises,
            onTap: () {
              Navigator.pushNamed(context, YogaStopWatchView.routeName);
            },
          ),
          SizedBox(height: Dimensions.boxHeight16), // 16.h
          RelaxationCard(
            assetsPath: Assets.habitTrackerWalk,
            title: S.of(context).outdoor_walking,
            onTap: () {
              Navigator.pushNamed(context, YogaStopWatchView.routeName);
              print('تم النقر على الكارد');
            },
          ),
          SizedBox(height: Dimensions.boxHeight16), // 16.h
          RelaxationCard(
            assetsPath: Assets.habitTrackerRead,
            title: S.of(context).reading_and_relaxation,
            onTap: () {
              Navigator.pushNamed(context, BookView.routeName);
              print('تم النقر على الكارد');
            },
          ),
          SizedBox(height: Dimensions.boxHeight16), // 16.h
          RelaxationCard(
            assetsPath: Assets.habitTrackerPodcast,
            title: S.of(context).podcasts,
            onTap: () {
              Navigator.pushNamed(context, PodcastsView.routeName);
              print('تم النقر على الكارد');
            },
          ),
        ],
      ),
    );
  }
}