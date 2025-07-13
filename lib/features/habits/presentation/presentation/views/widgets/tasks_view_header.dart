import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';

class TasksViewHeader extends StatelessWidget {
  const TasksViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).what_did_you_accomplish_today,
          style: AppStyles.text18SemiBold,
        ),
      ],
    );
  }
}