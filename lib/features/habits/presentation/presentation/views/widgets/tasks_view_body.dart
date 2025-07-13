import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/habit_cubit.dart';
import '../../controller/cubits/store_habit_cubit.dart';
import '../score_view.dart';
import 'habits_list_section.dart';
import 'tasks_view_button.dart';
import 'tasks_view_header.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingExtraLarge), // 24.w
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TasksViewHeader(),
            SizedBox(height: Dimensions.boxHeight20), // 20.h
            Expanded(
              child: BlocBuilder<HabitCubit, HabitState>(
                builder: (context, state) {
                  if (state is HabitLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.purple[700]),
                    );
                  } else if (state is HabitLoaded) {
                    return HabitsListSection(habits: state.habits);
                  } else if (state is HabitError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppStyles.text16Regular.copyWith(color: Colors.red[700]),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      S.of(context).no_data,
                      style: AppStyles.text16Regular.copyWith(color: Colors.grey[600]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Dimensions.boxHeight20), // 20.h
            const TasksViewButton(),
          ],
        ),
      ),
    );
  }
}