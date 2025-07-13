import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/relaxation_view_body.dart';
import '../../../../../core/constants/imports.dart';
import 'habit_tracker_view.dart';

class RelaxationView extends StatelessWidget {
  const RelaxationView({super.key});
  static const routeName = '/relaxation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: '',
        navigateTo: HabitTrackerView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: RelaxationViewBody(),
    );
  }
}