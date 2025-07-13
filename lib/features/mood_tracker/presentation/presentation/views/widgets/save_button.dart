import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_tracker/mood_tracker_cubit.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/mood_tracker_view_by_date.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.cubit,
  });

  final MoodTrackerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Dimensions.buttonWidth,
          height: Dimensions.buttonHeight40,
          child: CustomButton(
            textStyle: AppStyles.text18Button,
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                cubit.postMood();
              }
            },
            backgroundColor: AppColors.secondaryColor,
            style: AppStyles.buttonStyle,
            text: S.of(context).save,
          ),
        ),
      ],
    );
  }
}