import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../controller/cubits/habit_cubit.dart';
import '../../controller/cubits/store_habit_cubit.dart';
import '../score_view.dart';
import 'habit_card.dart';

class TasksViewButton extends StatelessWidget {
  const TasksViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreHabitCubit, StoreHabitState>(
      listener: (context, state) {
        if (state is StoreHabitSuccess) {
          Navigator.pushNamed(
            context,
            ScoreView.routeName,
            arguments: state.response,
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  final habitCubit = context.read<HabitCubit>();
                  if (habitCubit.state is HabitLoaded) {
                    final selectedIds = (habitCubit.state as HabitLoaded)
                        .habits
                        .where((habit) => HabitCard.habitCardStates[habit.id] ?? false)
                        .map((habit) => habit.id)
                        .toList();
                    final storeHabitCubit = context.read<StoreHabitCubit>();
                    storeHabitCubit.storeHabits(selectedIds);
                  }
                },
                text: S.of(context).save,
                backgroundColor: AppColors.secondaryColor,
                style: AppStyles.buttonStyle,
                textStyle: AppStyles.text16Regular,
              ),
            ),
          ],
        );
      },
    );
  }
}