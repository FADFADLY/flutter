import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/habits/presentation/presentation/views/widgets/tasks_view_body.dart';
import '../../../../../core/constants/imports.dart';
import '../../../domain/repo/repo.dart';
import '../controller/cubits/habit_cubit.dart';
import '../controller/cubits/store_habit_cubit.dart';
import 'habit_tracker_view.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});
  static const routeName = '/tasks';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitCubit(habitRepo: getIt<HabitRepo>())..getHabits(),
        ),
        BlocProvider(
          create: (context) => StoreHabitCubit(habitRepo: getIt<HabitRepo>()),
        ),
      ],
      child: Scaffold(
        body: TasksViewBody(),
        appBar: buildAppBar(
          context,
          title: '',
          navigateTo: HabitTrackerView.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
      ),
    );
  }
}