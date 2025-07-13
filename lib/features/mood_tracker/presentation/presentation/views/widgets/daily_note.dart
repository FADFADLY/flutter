import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_tracker/mood_tracker_cubit.dart';

class DailyNote extends StatelessWidget {
  const DailyNote({
    super.key,
    required this.cubit,
  });

  final MoodTrackerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AutoSizeText(
                    minFontSize: 0,
                    S.of(context).what_happened_to_you_today,
                    style: AppStyles.text16Regular,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.boxHeight15),
              CustomTextFormField(
                borderRadius: Dimensions.borderRadiusSmall,
                height: Dimensions.boxHeight214,
                controller: cubit.whatHappenedController,
                hintText: S.of(context).enter_todays_notes,
              ),
            ],
          ),
        );
      },
    );
  }
}