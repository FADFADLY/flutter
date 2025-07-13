import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/yoga_stop_watch_view_body.dart';
import '../../../../../core/constants/imports.dart';
import 'habit_tracker_view.dart';

class YogaStopWatchView extends StatelessWidget {
  const YogaStopWatchView({super.key});

  static const routeName = 'yoga_stop_watch_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).stop_watch,
        navigateTo: HabitTrackerView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: YogaStopWatchViewBody(),
    );
  }
}