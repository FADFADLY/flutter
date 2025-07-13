import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/habit_tracker_view_body.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../home/presentation/views/NavBar.dart';

class HabitTrackerView extends StatelessWidget {
  const HabitTrackerView({super.key});

  static const routeName = '/habit-tracker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HabitTrackerViewBody(),
      appBar: buildAppBar(
        context,
        title: '',
        navigateTo: BottomNavBar.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }
}