import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_tracker/mood_tracker_cubit.dart';

class FeelingToday extends StatelessWidget {
  const FeelingToday({
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    minFontSize: 0,
                    S.of(context).how_do_you_feel_today,
                    style: AppStyles.text16Regular,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.boxHeight15),
              CustomTextFormField(
                borderRadius: Dimensions.borderRadiusSmall,
                controller: cubit.whatYouFeelController,
                hintText: S.of(context).enter_your_answer,
              ),
            ],
          ),
        );
      },
    );
  }
}