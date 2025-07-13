import 'package:flutter/material.dart';
import '../../../../domain/entity/habit_data_entity.dart';
import 'habit_card.dart';

class HabitsListSection extends StatelessWidget {
  final List<HabitDataEntity> habits;

  const HabitsListSection({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return HabitCard(habit: habits[index]);
      },
    );
  }
}