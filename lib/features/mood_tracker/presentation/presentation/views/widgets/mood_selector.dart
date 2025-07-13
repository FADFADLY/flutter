import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_tracker/mood_tracker_cubit.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.cubit,
  });

  final MoodTrackerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
      ),
      padding: EdgeInsets.all(Dimensions.paddingMedium),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AutoSizeText(
                minFontSize: 0,
                S.of(context).how_is_your_mood_today,
                style: AppStyles.text16Regular,
              ),
            ],
          ),
          SizedBox(height: Dimensions.boxHeight15),
          BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(cubit.emojis.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.updateMood(index);
                    },
                    child: Container(
                      width: Dimensions.pinCodeFieldSize,
                      height: Dimensions.pinCodeFieldSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: cubit.currentMoodIndex == index
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          cubit.emojis[index],
                          style: AppStyles.text20Bold,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}