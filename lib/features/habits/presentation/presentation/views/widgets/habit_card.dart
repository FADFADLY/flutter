import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../domain/entity/habit_data_entity.dart';

class HabitCard extends StatefulWidget {
  final HabitDataEntity habit;

  const HabitCard({Key? key, required this.habit}) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();

  static Map<int, bool> habitCardStates = {};
}

class _HabitCardState extends State<HabitCard> {
  @override
  void initState() {
    super.initState();
    if (!HabitCard.habitCardStates.containsKey(widget.habit.id)) {
      HabitCard.habitCardStates[widget.habit.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight8), // 8.h
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge)), // 30.r
      color: HabitCard.habitCardStates[widget.habit.id]! ? Colors.green[100] : AppColors.backgroundColor,
      child: ListTile(
        contentPadding: EdgeInsets.all(Dimensions.paddingMedium), // 16.w
        leading: Image.network(
          widget.habit.icon,
          width: Dimensions.boxHeight40, // 40.w
          height: Dimensions.boxHeight40, // 40.h
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.error, color: Colors.red[300]),
        ),
        title: Text(
          widget.habit.name,
          style: AppStyles.text16SemiBold.copyWith(
            decoration: HabitCard.habitCardStates[widget.habit.id]! ? TextDecoration.lineThrough : TextDecoration.none,
            color: HabitCard.habitCardStates[widget.habit.id]! ? Colors.grey[600] : Colors.black87,
          ),
        ),
        trailing: Checkbox(
          value: HabitCard.habitCardStates[widget.habit.id]!,
          onChanged: (value) {
            setState(() {
              HabitCard.habitCardStates[widget.habit.id] = value ?? false;
            });
          },
          activeColor: Colors.green[700],
          checkColor: Colors.white,
        ),
      ),
    );
  }
}