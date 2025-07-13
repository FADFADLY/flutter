import 'package:graduationproject/features/habits/presentation/presentation/views/tasks_view.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/score_view_body.dart';
import '../../../../../core/constants/imports.dart';
import '../../../domain/repo/repo.dart';
import '../controller/cubits/store_habit_cubit.dart';
import '../../../domain/entity/store_habits_response_entity.dart';

class ScoreView extends StatelessWidget {
  final StoreHabitsResponseEntity? response;

  const ScoreView({super.key, this.response});

  static const String routeName = '/score';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).test_result,
        navigateTo: TasksView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: ScoreViewBody(response: response),
    );
  }
}